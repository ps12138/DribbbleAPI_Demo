//
//  Comment.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation

open class Comment {
    open let id: Int
    open var body: String
    open let likes_count: Int
    open let likes_url: String
    open let created_at: String
    open let updated_at: String
    
    open let user: User
    open var commentBody: CommentBody?

    
    init?(dict: Dictionary<String, AnyObject>?) {
        guard
            let id = dict?[CommentKey.id] as? Int,
            let body = dict?[CommentKey.body] as? String,
            let likes_count = dict?[CommentKey.likes_count] as? Int,
            let likes_url = dict?[CommentKey.likes_url] as? String,
            let created_at = dict?[CommentKey.created_at] as? String,
            let updated_at = dict?[CommentKey.updated_at] as? String,
            let user = User(dict: dict?[ShotKey.user] as? Dictionary<String, AnyObject>)
        else {
            return nil
        }
       
        self.id = id
        self.body = body
        self.likes_count = likes_count
        self.likes_url = likes_url
        self.created_at = created_at
        self.updated_at = updated_at
        self.user = user
    }
    
    public func translateBody(dict: Dictionary<String, AnyObject>?) {
        self.commentBody = CommentBody(dict: dict)
    }
}

