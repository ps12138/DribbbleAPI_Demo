//
//  BaseNetwork+PrivateMethod.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - private method
extension BaseNetwork {
    
    // MARK: - token internal method
    internal func implementUpdateToken(_ token: String?) {
        if let tokenString = token {
            alamofireManager.adapter = AccessTokenAdapter(accessToken: tokenString)
        }
    }
    
    // MARK: - reachability internal method
    internal func implementStartReachListener(host: String?) {
        guard let urlString = host else {
            return
        }
        self.netReachManager = NetworkReachabilityManager(host: urlString)
        self.netReachManager?.listener = {
            status in
            print("BaseNetwork: Network Status Changed: \(status)")
        }
        netReachManager?.startListening()
        print("BaseNetwork: listening \(urlString)")
    }
    
    internal func implementstopReachListener() {
        netReachManager?.stopListening()
        print("BaseNetwork: stop listening")
        
    }
    
    // MARK: - perform request internal method
    internal func implementPerform(
        getFrom url: String,
        parameters: Dictionary<String,String>,
        headers: Dictionary<String,String>,
        success:((String?) -> Void)?,
        failure:((Error?, String?) -> Void)?
    ) {
        // perform request and handle result
        alamofireManager.request(
            url,
            method: .get,
            parameters: parameters,
            headers: headers
            ).responseString { response in
                if let error = response.result.error {
                    failure?(error, response.result.value)
                } else {
                    success?(response.result.value)
                }
        }// closure
    }

    
    internal func implementPerform(
        postTo url: String,
        parameters: Dictionary<String,String>,
        headers: Dictionary<String,String>,
        success:((String?) -> Void)?,
        failure:((Error?, String?) -> Void)?
    ) {
        // perform request and handle result
        alamofireManager.request(
            url,
            method: .post,
            parameters: parameters,
            headers: headers
            ).responseString { response in
                if let error = response.result.error {
                    failure?(error, response.result.value)
                } else {
                    //print(response.response!)
                    success?(response.result.value)
                }
        }// closure
    }
    
    
    internal func implementPerform(
        request: URLRequest,
        failure: ((Error?, DataResponse<Data>?) -> Void)? = nil,
        success: ((Data?) -> Void)?
    ) {
        // perform request and handle result
        alamofireManager.request(request)
            .validate(statusCode: 200..<300)
            .responseData { response in
                if let error = response.result.error {
                    let doFailure = failure ?? self.handleFailure
                    doFailure(error, response)
                } else {
                    success?(response.result.value)
                }
        }// closure
    }

    internal func handleFailure(_ errorString: Error?, _ response: DataResponse<String>?) {
        
        if let error = errorString {
            print("Error: \(error)")
        }
        if let responseArray = response {
            print("HandleFailure : Request : \n\(responseArray.request)")
            print("HandleFailure : Data : \n\(responseArray.result.value)")
        }
    }
    
    internal func handleFailure(_ errorString: Error?, _ response: DataResponse<Data>?) {
        
        if let error = errorString {
            print("Error: \(error)")
        }
        if let responseArray = response {
            print("HandleFailure : Request : \n\(responseArray.request)")
            print("HandleFailure : Data : \n\(responseArray.result.value)")
        }
    }    
}