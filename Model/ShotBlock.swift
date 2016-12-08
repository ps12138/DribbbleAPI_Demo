//
//  ShotBlock.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation

open class ShotBlock {
    // image property
    open let id: Int
    open let title: String
    open let desc: String
    
    open let width: Int
    open let height: Int
    open let image: ImageBlock
    
    // image related
    open var views_count: Int
    open var likes_count: Int
    open var comments_count: Int
    
    // api related
    open let likes_url: String
    
    // user related
    open let created: String
    open let updated: String
    
    open var user: User?
    open var descBody: DescriptionBody?
    
    init?(dict: Dictionary<String, AnyObject>?) {
        guard
            let id = dict?[ShotKey.id] as? Int,
            
            let width = dict?[ShotKey.width] as? Int,
            let height = dict?[ShotKey.height] as? Int,
            let image = ImageBlock(dict: dict?[ShotKey.images] as? Dictionary<String, AnyObject>),
    
            let views_count = dict?[ShotKey.views_count] as? Int,
            let likes_count = dict?[ShotKey.likes_count] as? Int,
            let comments_count = dict?[ShotKey.comments_count] as? Int,
        
            let likes_url = dict?[ShotKey.likes_url] as? String,
            let created = dict?[ShotKey.created_at] as? String,
            let updated = dict?[ShotKey.updated_at] as? String
        else {
            return nil
        }
        self.id = id
        self.title = (dict?[ShotKey.title] as? String) ?? ""
        self.desc = (dict?[ShotKey.description] as? String) ?? "No Description"
        
        self.width = width
        self.height = height
        self.image = image
        
        self.views_count = views_count
        self.likes_count = likes_count
        self.comments_count = comments_count
        
        self.likes_url = likes_url
        
        self.created = created
        self.updated = updated
        self.user = User(dict: dict?[ShotKey.user] as? Dictionary<String, AnyObject>)
    }
    
    public func translateDescBody(dict: Dictionary<String, AnyObject>?) {
        self.descBody = DescriptionBody(dict: dict)
    }
}





