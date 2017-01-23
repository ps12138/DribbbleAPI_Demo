//
//  RequestFormer+URLform.swift
//  DribbbleAPI_Demo
//
//  Created by PSL on 1/22/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation

// MARK: - form url string
extension RequestFormer {
    
    internal func formUrlString(_ from: DribbleAPIBase) -> String? {
        switch from {
        
        // about like operation
        case .likeShot(let shotID):
            return formString(like: shotID)
        case .checkLikeShot(let shotID):
            return formString(like: shotID)
        case .unlikeShot(let shotID):
            return formString(like: shotID)
        
        // about auth user
        case .activeUser:
            return "\(Api.base)\(Api.activeUser)"
        case .activeUserLikesByPage(let page):
            return "\(Api.base)\(Api.activeUser)\(Api.listLikes)\(Api.page)\(page)"
        case .activeUserShotsByPage(let page):
            return "\(Api.base)\(Api.activeUser)\(Api.listShots)\(Api.page)\(page)"
        case .activeUserFollowersByPage(let page):
            return "\(Api.base)\(Api.activeUser)\(Api.listFollowers)\(Api.page)\(page)"
        case .activeUserFollowingByPage(let page):
            return "\(Api.base)\(Api.activeUser)\(Api.listFollowing)\(Api.page)\(page)"
            
        // about other user
        case .listUserShotsByPage(let userID, let page):
            return formString(userShots: userID, page: page)
        case .listUserLikesByPage(let userID, let page):
            return formString(userLikes: userID, page: page)
        case .listUserFollowersByPage(let userID, let page):
            return formString(userFollowers: userID, page: page)
        case .listUserFollowingByPage(let userID, let page):
            return formString(userFollowing: userID, page: page)
            
        // about shots
        case .listShotsByPage(let page):
            return formString(listShotsByPage: page, perPage: DefaultCons.perPageInt, sort: DefaultCons.sortString)
        case .listShotsByPagePerpage(let page, let perPage):
            return formString(listShotsByPage: page, perPage: perPage, sort: DefaultCons.sortString)
        case .listShotsByPageCustomSearch(let page, let sort):
            return formString(listShotsByPage: page, perPage: DefaultCons.perPageInt, sort: sort)
        case .listShotsByPagePerpageCustomSearch(let page, let perPage, let sort):
            return formString(listShotsByPage: page, perPage: perPage, sort: sort)
            
        case .listShotComments(let shotID):
            return formString(listComments: shotID)
        case .listLikesForComment(let shotID, let commentID):
            return formString(listLikesForComment: shotID, commentID)
        case .listShotCommentsByPage(let shotID, let page):
            return formString(listComments: shotID, page: page)
            
        
        // about comment
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
    
    
    private func formString(listShotsByPage page: Int, perPage: Int, sort: String) -> String {
        let urlString = "\(Api.base)\(Api.listShots)\(Api.page)\(page)\(Api.perPage)\(perPage)\(sort)"
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
}
