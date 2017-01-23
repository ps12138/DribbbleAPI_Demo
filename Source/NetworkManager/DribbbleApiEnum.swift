//
//  DribbbleApiEnum.swift
//  opShot_Demo
//
//  Created by PSL on 12/12/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation

public enum DribbleAuthApi {
    
    case Error
    // Int: ID
    case likeShot(Int)
    case checkLikeShot(Int)
    case unlikeShot(Int)
    
    // Int: shotId or commentId
    case activeUser
    case activeUserCheckShotLike(Int)
    case activeUserCheckCommentLike(Int)
    // Int: page
    case activeUserLikesByPage(Int)
    case activeUserShotsByPage(Int)
    case activeUserFollowersByPage(Int)
    case activeUserFollowingByPage(Int)
    

    // Int: userID, page
    case listUserLikesByPage(Int, Int)
    case listUserShotsByPage(Int, Int)
    case listUserFollowersByPage(Int, Int)
    case listUserFollowingByPage(Int, Int)
    
    // Int: page, perpage
    case listShotsByPage(Int)
    case listShotsByPagePerpage(Int, Int)
    case listShotsByPageCustomSearch(Int, String)
    case listShotsByPagePerpageCustomSearch(Int, Int, String)
    
    // shotID, commentID
    case listShotComments(Int)
    case listLikesForComment(Int, Int)
    // shotID, page
    case listShotCommentsByPage(Int, Int)
    
    // shotID, bodyString
    case createComment(Int, String)
    case deleteComment(Int)
    
    // shotID, commentID
    case likeComment(Int, Int)
    case unlikeComment(Int, Int)
}
