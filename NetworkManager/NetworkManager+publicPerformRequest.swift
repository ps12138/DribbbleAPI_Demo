//
//  NetworkManager+PerformRequest.swift
//  DribbbleModuleFrameworkShadow
//
//  Created by PSL on 12/8/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    fileprivate struct UrlConstants {
        static let base = "https://api.dribbble.com/v1/"
    }


    // MARK: - formRequestFromSelectByPage
    public func formRequestFromSelectByPage(
        _ method: String,
        path: String,
        param: Dictionary<String, String>
    ) -> URLRequest {
        
        // form url
        let url = URL(string: "\(UrlConstants.base)\(path)")!
        var request = URLRequest(url: url)
        
        // form httpmethod
        request.httpMethod = method
        
        // form paramters
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: param, options: [])
        } catch {
            print("NetM.perfromR: fail to form httpBody")
        }
        print("selectByPage url: \(request.url)")
        return request
    }
    
    // MARK: - formRequestFromSelectByPage
    public func formRequestFromSelectByPage(_ method: String, path: String) -> URLRequest {
        
        // form url
        let url = URL(string: "\(NetworkManager.UrlConstants.base)\(path)")!
        var request = URLRequest(url: url)
        
        // form httpmethod
        request.httpMethod = method
        
        // form paramters
        print("NetM.perfromR: form selectByPage url: \(request.url)")
        return request
    }
    
    
    public func performRequest(request: URLRequest, _ success: @escaping ([ShotBlock])->Void) {
        print("NetM.perfromR: perform request")
        baseNetwork.performRequest(request: request) {
            results in
            print("NetM.perfromR: Json get")
            let blocks = self.parseJson.parse(listShot:results)
            success(blocks)
        }
    }
    
    // --------------------------------------------------------
    // MARK: - form request for given Api
    public func formRequest(_ method: String, urlString: String) -> URLRequest? {
        
        // form url
        guard let url = URL(string: "\(urlString)") else {
            print("NetM.perfromR: unvalid urlString")
            return nil
        }
        var request = URLRequest(url: url)
        
        // form httpmethod
        request.httpMethod = method
        
        // form paramters
        print("NetM.perfromR: form request url: \(request.url!)")
        return request
    }
    
    // --------------------------------------------------------
    // MARK: - perfrom request for shots/likes bypage
    public func perform(byPageRequest: URLRequest, _ success: @escaping ([ShotBlock])->Void) {
        print("NetM.perfrom: shots/page request")
        baseNetwork.performRequest(request: byPageRequest) {
            results in
            print("NetM.perfrom: shots/page get")
            let blocks = self.parseJson.parse(listShot: results)
            success(blocks)
        }
    }
    
    // MARK: - perfrom request for user shots bypage
    public func perform(userShotsRequest: URLRequest, _ success: @escaping ([ShotBlock])->Void) {
        print("NetM.perfrom: userShots")
        baseNetwork.performRequest(request: userShotsRequest) {
            results in
            print("NetM.perfrom: userShots get")
            let blocks = self.parseJson.parse(listShot: results)
            success(blocks)
        }
    }
    
    // MARK: - perfrom request for user likes bypage
    public func perform(userLikesRequest: URLRequest, _ success: @escaping ([ShotBlock])->Void) {
        print("NetM.perfrom: userLikes request")
        baseNetwork.performRequest(request: userLikesRequest) {
            results in
            print("NetM.perfrom: userLikes get")
            let blocks = self.parseJson.parse(userLikes: results)
            success(blocks)
        }
    }
    
    
    
    
    
    
    // MARK: - perfrom request for id
    // MARK: - like a shot
    // MARK: - unlike a shot
    // MARK: - like a comment
    // MARK: - unlike a comment
    public func perform(idRequest: URLRequest, handleId success: @escaping (Int?)->Void) {
        print("NetM.perfrom: request sessionid")
        baseNetwork.performRequest(request: idRequest) {
            results in
            print("NetM.perfrom: sessionid get")
            let id = self.parseJson.parse(sessionid: results)
            success(id)
        }
    }
    
    // MARK: - perfrom request for id List
    public func perform(idListRequest: URLRequest, handleId success: @escaping (Dictionary<Int, Int>?)->Void) {
        print("NetM.perfrom: request idMap")
        baseNetwork.performRequest(request: idListRequest) {
            results in
            print("NetM.perfrom: idMap Json get")
            let idList = self.parseJson.parse(sessionidMapToshotid: results)
            success(idList)
        }
    }
    
    // MARK: - perfrom request for user
    public func perform(userRequest: URLRequest, handleId success: @escaping (User?)->Void) {
        print("NetM.perfrom: user request")
        baseNetwork.performRequest(request: userRequest) {
            results in
            print("NetM.perfrom user get")
            let user = self.parseJson.parse(user: results)
            success(user)
        }
    }
    
    // MARK: - perfrom request for listShotComments
    public func perform(commentsRequest: URLRequest, handleId success: @escaping ([Comment])->Void) {
        print("NetM.perfrom: comments request")
        baseNetwork.performRequest(request: commentsRequest) {
            results in
            print("NetM.perfrom: comments get")
            let comments = self.parseJson.parse(comments: results)
            success(comments)
        }
    }
    
    // MARK: - perfrom request for list, likes for a comment
    // TODO
    
    
    // MARK: - perfrom request for create a comment
    public func perform(createCommentRequest: URLRequest, handleId success: @escaping (Comment?)->Void) {
        print("NetM.perfrom: comment create")
        baseNetwork.performRequest(request: createCommentRequest) {
            results in
            print("NetM.perfrom: comment get")
            let comment = self.parseJson.parse(comment: results)
            success(comment)
        }
    }
    
    // MARK: - perfrom request for delete a comment
    public func perform(deleteCommentRequest: URLRequest, handleId success: @escaping (Bool)->Void) {
        print("NetM.perfrom: comment delete")
        baseNetwork.performRequest(request: deleteCommentRequest) {
            result in
            //print("NetMan: user Json get")
            success(true)
        }
    }

}
