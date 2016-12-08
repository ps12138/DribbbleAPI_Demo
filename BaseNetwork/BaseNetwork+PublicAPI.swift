//
//  BaseNetwork+PublicAPI.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - API
extension BaseNetwork {
    
    // MARK: - updateToken
    public func updateToken(_ token: String?) {
        implementUpdateToken(token)
    }
    
    // MARK: - Network Reachability Manager
    public func startReachListener(host: String?) {
        implementStartReachListener(host: host)
    }
    
    public func stopReachListener() {
        implementstopReachListener()
    }
    
    // MARK: - perform request from URL
    public func perform(
        getFrome url: String,
        parameters: Dictionary<String,String>,
        headers: Dictionary<String,String>,
        success:((String?) -> Void)?,
        failure:((Error?, String?) -> Void)?
    ) {
        implementPerform(
            getFrom: url,
            parameters: parameters,
            headers: headers,
            success: success,
            failure: failure
        )
    }
    
    public func perform(
        postTo url: String,
        parameters: Dictionary<String,String>,
        headers: Dictionary<String,String>,
        success:((String?) -> Void)?,
        failure:((Error?, String?) -> Void)?) {
        // perform request and handle result
        implementPerform(
            postTo: url,
            parameters: parameters,
            headers: headers,
            success: success,
            failure: failure
        )
    }
    
    // MARK: - perform URLRequest
    // only handle success
    public func performRequest(
        request: URLRequest,
        success: ((Data?) -> Void)?
    ) {
        implementPerform(
            request: request,
            failure: nil,
            success: success
        )
    }
    
    // with handle failure error/errorData and success
    public func perform(
        request: URLRequest,
        failure: ((Error?, DataResponse<Data>?) -> Void)? = nil,
        success: ((Data?) -> Void)?
    ) {
        implementPerform(
            request: request,
            failure: failure,
            success: success
        )
    }
}
