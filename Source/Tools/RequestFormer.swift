//
//  RequestFormer.swift
//  DribbbleAPI_Demo
//
//  Created by PSL on 1/22/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


struct RequestFormer {
        
    // MARK: - public method
    public func formRequest(_ from: DribbleAPIBase) -> URLRequest?{
        
        var urlString: String? {
            return formUrlString(from)
        }
        var httpMethod: String? {
            return formHttpMethod(from)
        }
        var httpBody: Data? {
            return formHttpBody(from)
        }
        var cachePolicy: URLRequest.CachePolicy {
            return formCachePolicy(from)
        }
        
        guard
            httpMethod != nil,
            let absoluteString = urlString,
            let url = URL(string: absoluteString)
            else {
            print("NetM.formReq: fail to form request")
            return nil
        }
        
        // form request
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.cachePolicy = cachePolicy
        // add body
        request.httpBody = httpBody
        
        print("NetM.formReq: form req \(request.url!)")
        return request
    }
    
    // MARK: - Api constant
    internal struct DefaultCons {
        static let perPageInt = 12
        static let sortString = ""
    }
    
    
    internal struct Api {
        static let base = "https://api.dribbble.com/v1/"
        static let shots = "shots/"
        static let like = "like"
        
        static let listLikes = "likes"
        static let listShots = "shots"
        static let listFollowers = "followers"
        static let listFollowing = "following"
        
        static let activeUser = "user/"
        static let users = "users/"
        
        static let comments = "comments"
        static let page = "?page="
        static let perPage = "&per_page="
        
        static let paraBegin = "?"
        static let paraBetween = "&"
    }
}
