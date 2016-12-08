//
//  DescriptionBody.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation

open class DescriptionBody {
    open var body: String?
    open var hashTag: [String: Int]?
    
    init?(dict: Dictionary<String, AnyObject>?) {
        
        self.body = dict?[DescriptionBodyKey.body] as? String
        self.hashTag = dict?[DescriptionBodyKey.hashTag] as? Dictionary<String, Int>
        
        if self.body == nil, self.hashTag == nil {
            return nil
        }
        //print("CommentBody: \(hashTag)")
    }
    
    // MARK: - description body key (html)
    private struct DescriptionBodyKey {
        static let body = "p"
        static let hashTag = "a"
    }

}

