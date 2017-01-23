//
//  ImageBlock.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation


open class ImageBlock {
    
    open var url = Array<String>()
    open var largeImageUrl: String? {
        return url.first
    }
    open var smallImageUrl: String? {
        return url.last
    }
    
    init?(dict: Dictionary<String, AnyObject>?) {
        if let hidpiURL = dict?[ImageBlockKey.hidipi] as? String {
            url.append(hidpiURL)
        }
        
        if let normalURL = dict?[ImageBlockKey.normal] as? String {
            url.append(normalURL)
        }
        
        if let teaserURL = dict?[ImageBlockKey.teaser] as? String {
            url.append(teaserURL)
        }
        
        if url.isEmpty {
            return nil
        }
    }
}


