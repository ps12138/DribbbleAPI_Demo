//
//  JsonKeys.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation

// MARK: - shot key
public struct ShotKey {
    static let id = "id"
    static let title = "title"
    static let description = "description"
    
    static let width = "width"
    static let height = "height"
    
    static let images = "images"
    
    static let views_count = "views_count"
    static let likes_count = "likes_count"
    static let comments_count = "comments_count"
    static let attachments_count = "attachments_count"
    static let rebounds_count = "rebounds_count"
    static let buckets_count = "buckets_count"
    static let created_at = "created_at"
    static let updated_at = "updated_at"
    static let html_url = "html_url"
    static let attachments_url = "attachments_url"
    static let buckets_url = "buckets_url"
    static let comments_url = "comments_url"
    static let likes_url = "likes_url"
    static let projects_url = "projects_url"
    static let rebounds_url = "rebounds_url"
    static let animated = "animated"
    static let tags = "tags"
    
    static let user = "user"
}


// MARK: - user key
public struct UserKey {
    // Int, id
    static let id = "id"
    // String
    static let name = "name"
    static let username = "username"
    static let html_url = "html_url"
    static let avatar_url = "avatar_url"
    static let bio = "bio"
    static let location = "location"
    
    // Dict
    static let links = "links"
    
    // Int count
    static let buckets_count = "buckets_count"
    static let comments_received_count = "comments_received_count"
    static let followers_count = "followers_count"
    static let followings_count = "followings_count"
    static let likes_count = "likes_count"
    static let likes_received_count = "likes_received_count"
    static let projects_count = "projects_count"
    static let rebounds_received_count = "rebounds_received_count"
    static let shots_count = "shots_count"
    static let teams_count = "teams_count"
    // Bool
    static let can_upload_shot = "can_upload_shot"
    //String
    static let type = "type"
    // Bool
    static let pro = "pro"
    // String
    static let buckets_url = "buckets_url"
    static let followers_url = "followers_url"
    static let following_url = "following_url"
    static let likes_url = "likes_url"
    static let projects_url = "projects_url"
    static let shots_url = "shots_url"
    static let teams_url = "teams_url"
    static let created_at = "created_at"
    static let updated_at = "updated_at"
}

// MARK: - image block key
public struct ImageBlockKey {
    static let hidipi = "hidipi"
    static let normal = "normal"
    static let teaser = "teaser"
}


// MARK: - comment key
public struct CommentKey {
    static let id = "id"
    static let body = "body"
    static let likes_count = "likes_count"
    
    static let likes_url = "likes_url"
    static let created_at = "created_at"
    static let updated_at = "updated_at"
    
    static let user = "user"
}

