//
//  RequestFormer+HTTPMethods.swift
//  DribbbleAPI_Demo
//
//  Created by PSL on 1/22/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation

// MARK: - form the HttpMethods
extension RequestFormer {
    
    internal func formHttpMethod(_ from: DribbleAPIBase) -> String? {
        switch from {
        // about like operation
        case .likeShot:
            return "POST"
        case .checkLikeShot:
            return "GET"
        case .unlikeShot:
            return "DELETE"
        
        // about auth user
        case .activeUser,
             .activeUserLikesByPage,
             .activeUserShotsByPage,
             .activeUserFollowersByPage,
             .activeUserFollowingByPage:
            return "GET"
            
        // aobut shots
        case .listShotsByPage,
             .listShotsByPagePerpage,
             .listShotsByPageCustomSearch,
             .listShotsByPagePerpageCustomSearch:
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
            
        // about comments
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

}
