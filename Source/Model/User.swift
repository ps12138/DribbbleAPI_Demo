//
//  User.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation

open class User {
    open let id: Int
    open let name: String?
    open let userName: String?
    open let html_url: String?
    open let avatar_url: String?
    open let bio: String?
    open let location: String
    
    open let linkDict: Dictionary<String, String>?
    open var linkArray: [(title: String, urlString: String)]?
    
    open let buckets_count: Int
    open let comments_received_count: Int
    open let followers_count: Int
    open let followings_count: Int
    open let likes_count: Int
    open let likes_received_count: Int
    open let projects_count: Int
    open let rebounds_received_count: Int
    open let shots_count: Int
    open let teams_count: Int
    
    init?(dict: Dictionary<String, AnyObject>?) {
        guard let id = dict?[UserKey.id] as? Int,
            let userName = dict?[UserKey.username] as? String,
            let buckets_count = dict?[UserKey.buckets_count] as? Int,
            let comments_received_count = dict?[UserKey.comments_received_count] as? Int,
            let followers_count = dict?[UserKey.followers_count] as? Int,
            let followings_count = dict?[UserKey.followings_count] as? Int,
            let likes_count = dict?[UserKey.likes_count] as? Int,
            let likes_received_count = dict?[UserKey.likes_received_count] as? Int,
            let projects_count = dict?[UserKey.projects_count] as? Int,
            let rebounds_received_count = dict?[UserKey.rebounds_received_count] as? Int,
            let shots_count = dict?[UserKey.shots_count] as? Int,
            let teams_count = dict?[UserKey.teams_count] as? Int
        else {
            return nil
        }
        self.id = id
        self.name = dict?[UserKey.name] as? String
        self.userName = userName
        self.html_url = dict?[UserKey.html_url] as? String
        self.avatar_url = dict?[UserKey.avatar_url] as? String
        self.bio = dict?[UserKey.bio] as? String
        self.location = (dict?[UserKey.location] as? String) ?? "unknown"
        
        self.linkDict = dict?[UserKey.links] as? Dictionary<String, String>
        
        self.buckets_count = buckets_count
        self.comments_received_count = comments_received_count
        self.followers_count = followers_count
        self.followings_count = followings_count
        self.likes_count = likes_count
        self.likes_received_count = likes_received_count
        self.projects_count = projects_count
        self.rebounds_received_count = rebounds_received_count
        self.shots_count = shots_count
        self.teams_count = teams_count
    }
    
    open var links: [(title: String, urlString: String)]? {
        if let validLinks = linkArray {
            return validLinks
        } else {
            return convertFrom(dict: linkDict)
        }
    }

    private func convertFrom(dict: Dictionary<String, String>?) -> [(title: String, urlString: String)]? {
        
        guard let validDict = dict else {
            return nil
        }
        var result = [(title: String, urlString: String)]()
        for (key, value) in validDict {
            result.append((title: key, urlString: value))
        }
        return result
    }

}



