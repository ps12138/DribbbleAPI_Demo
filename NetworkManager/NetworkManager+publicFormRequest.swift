//
//  NetworkManager+FormRequest.swift
//  DribbbleModuleFrameworkShadow
//
//  Created by PSL on 12/8/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation


extension NetworkManager {
    
    // MARK: - public method
    public func formRequest(_ from: DribbleAuthApi) -> URLRequest?{
        
        var urlString: String? {
            return formUrlString(from)
        }
        var httpMethod: String? {
            return formHttpMethod(from)
        }
        
        var httpBody: Data? {
            switch from {
            case .createComment( _, let content):
                return formBody(bodyString: content)
            default:
                return nil
            }
        }
        
        guard
            httpMethod != nil,
            let absoluteString = urlString,
            let url = URL(string: absoluteString)
            else {
                print("NetM.formReq: fail to form request")
                return nil
        }
        
        // form request
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        // add body
        request.httpBody = httpBody
        
        print("NetM.formReq: form req \(request.url!)")
        return request
    }
    
    // MARK: - Api constant
    fileprivate struct Api {
        static let base = "\(Constants.apiBase)/v1/"
        static let shots = "shots/"
        static let like = "like"
        
        static let listLikes = "likes"
        static let listShots = "shots"
        static let listFollowers = "followers"
        static let listFollowing = "following"
        
        static let activeUser = "user/"
        static let users = "users/"
        
        static let comments = "comments"
        static let page = "?page="
    }

    // MARK: - Private method
    private func formUrlString(_ from: DribbleAuthApi) -> String? {
        switch from {
        case .likeShot(let shotID):
            return formString(like: shotID)
        case .checkLikeShot(let shotID):
            return formString(like: shotID)
        case .unlikeShot(let shotID):
            return formString(like: shotID)
            
        case .activeUser:
            return "\(Api.base)\(Api.activeUser)"
        case .activeUserLikes:
            return "\(Api.base)\(Api.activeUser)\(Api.listLikes)"
        case .activeUserLikesByPage(let page):
            return "\(Api.base)\(Api.activeUser)\(Api.listLikes)\(Api.page)\(page)"
        case .activeUserShotsByPage(let page):
            return "\(Api.base)\(Api.activeUser)\(Api.listShots)\(Api.page)\(page)"
        case .activeUserFollowersByPage(let page):
            return "\(Api.base)\(Api.activeUser)\(Api.listFollowers)\(Api.page)\(page)"
        case .activeUserFollowingByPage(let page):
            return "\(Api.base)\(Api.activeUser)\(Api.listFollowing)\(Api.page)\(page)"
            
            
        case .listUserShotsByPage(let userID, let page):
            return formString(userShots: userID, page: page)
        case .listUserLikesByPage(let userID, let page):
            return formString(userLikes: userID, page: page)
        case .listUserFollowersByPage(let userID, let page):
            return formString(userFollowers: userID, page: page)
        case .listUserFollowingByPage(let userID, let page):
            return formString(userFollowing: userID, page: page)
            
            
            
        case .listShotComments(let shotID):
            return formString(listComments: shotID)
        case .listLikesForComment(let shotID, let commentID):
            return formString(listLikesForComment: shotID, commentID)
        case .listShotCommentsByPage(let shotID, let page):
            return formString(listComments: shotID, page: page)
            
            
        case .createComment(let shotID, _):
            return "\(Api.base)\(Api.shots)\(shotID)/\(Api.comments)"
        case .deleteComment(let shotID):
            return "\(Api.base)\(Api.shots)\(shotID)/\(Api.comments)"
            
        case .likeComment(let shotID, let commentID):
            return formString(likeComment: shotID, commentID)
        case .unlikeComment(let shotID, let commentID):
            return formString(likeComment: shotID, commentID)
            
        default:
            return nil
        }
    }
    
    private func formHttpMethod(_ from: DribbleAuthApi) -> String? {
        switch from {
        case .likeShot:
            return "POST"
        case .checkLikeShot:
            return "GET"
        case .unlikeShot:
            return "DELETE"
            
        case .activeUser:
            return "GET"
        case .activeUserLikes:
            return "GET"
        case .activeUserLikesByPage,
             .activeUserShotsByPage,
             .activeUserFollowersByPage,
             .activeUserFollowingByPage:
            return "GET"
            
            
        case .listUserShotsByPage,
             .listUserLikesByPage,
             .listUserFollowersByPage,
             .listUserFollowingByPage:
            return "GET"
            
        case .listShotComments,
             .listLikesForComment,
             .listShotCommentsByPage:
            return "GET"
            
        case .createComment:
            return "POST"
        case .deleteComment:
            return "DELETE"
            
        case .likeComment:
            return "POST"
        case .unlikeComment:
            return "DELETE"
            
        default:
            return nil
        }
    }
    
    
    // form String for url
    private func formString(like shotID: Int) -> String {
        let urlString = "\(Api.base)\(Api.shots)\(shotID)/\(Api.like)"
        return urlString
    }
    
    private func formString(userLikes userID: Int, page: Int) -> String {
        let urlString = "\(Api.base)\(Api.users)\(userID)/\(Api.listLikes)\(Api.page)\(page)"
        return urlString
    }
    
    private func formString(userShots userID: Int, page: Int) -> String {
        let urlString = "\(Api.base)\(Api.users)\(userID)/\(Api.listShots)\(Api.page)\(page)"
        return urlString
    }
    
    private func formString(userFollowers userID: Int, page: Int) -> String {
        let urlString = "\(Api.base)\(Api.users)\(userID)/\(Api.listFollowers)\(Api.page)\(page)"
        return urlString
    }
    
    private func formString(userFollowing userID: Int, page: Int) -> String {
        let urlString = "\(Api.base)\(Api.users)\(userID)/\(Api.listFollowing)\(Api.page)\(page)"
        return urlString
    }
    
    
    private func formString(listComments shotID: Int) -> String {
        let urlString = "\(Api.base)\(Api.shots)\(shotID)/\(Api.comments)"
        return urlString
    }
    
    private func formString(listComments shotID: Int, page: Int) -> String {
        let urlString = "\(Api.base)\(Api.shots)\(shotID)/\(Api.comments)\(Api.page)\(page)"
        return urlString
    }
    
    private func formString(listLikesForComment shotID: Int, _ commentID: Int) -> String {
        let urlString = "\(Api.base)\(Api.shots)\(shotID)/\(Api.comments)/\(commentID)/\(Api.listLikes)"
        return urlString
    }
    
    private func formString(likeComment shotID: Int, _ commentID: Int) -> String {
        let urlString = "\(Api.base)\(Api.shots)\(shotID)/\(Api.comments)/\(commentID)/\(Api.listLikes)"
        return urlString
    }
    
    private func formBody(bodyString: String) -> Data? {
        let dict = ["body": bodyString]
        let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
        return data
    }
    
}
