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
        alamofireManager.adapter = AccessTokenAdapter(accessToken: token)
    }
    
    // MARK: - reachability internal method
    internal func implementStartReachListener(
        host: String?,
        callBack: @escaping (NetworkReachability) -> Void) {
        
        guard let urlString = host else {
            return
        }
        netReachManager = NetworkReachabilityManager(host: urlString)
        netReachManager?.listener = {
            status in
            print("BaseNetwork: Network Status Changed: \(status)")
            switch status {
            case .reachable(let type):
                if type == NetworkReachabilityManager.ConnectionType.wwan {
                    callBack(.online(.cell))
                } else {
                    callBack(.online(.wifi))
                }
            case .notReachable:
                callBack(.offline)
            default:
                callBack(.unknown)
            }
        }
        netReachManager?.startListening()
        print("BaseNetwork: listening \(urlString)")
    }
    
    internal func implementstopReachListener() {
        netReachManager?.stopListening()
        print("BaseNetwork: stop listening")
        
    }
    
    // MARK: - perform download with progress
    internal func implementPerform(
        downloadFrom url: String,
        progress progressCallBack: ((Double) -> Void)? = nil,
        data dataCallBack: ((Data?) -> Void)?){
        
        alamofireManager.download(url)
            .downloadProgress {
                progressStatus in
                progressCallBack?(progressStatus.fractionCompleted)
            }
            .responseData {responseReceived in
              dataCallBack?(responseReceived.result.value)
        }
    }

    // MARK: - perform download with qos progress
    internal func implementPerform(
        downloadFrom url: String,
        progressInQos progressCallBack: ((Double) -> Void)?,
        data dataCallBack: ((Data?) -> Void)?){
        
        // using qos queue to take progress
        let utilityQueue = DispatchQueue.global(qos: .utility)
        alamofireManager.download(url)
            .downloadProgress(queue: utilityQueue) {
                progress in
                progressCallBack?(progress.fractionCompleted)
            }
            .responseData {response in
                dataCallBack?(response.result.value)
        }
    }
    
    
    
    
    
    
    // MARK: - perform request internal method
    internal func implementPerform(
        getFrom url: String,
        parameters: Dictionary<String,String>,
        headers: Dictionary<String,String>,
        success:((String?) -> Void)?,
        failure:((Error?, String?) -> Void)?) {
        
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
        failure:((Error?, String?) -> Void)?) {
        
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
        success: ((Data?) -> Void)?,
        failure: ((Error?) -> Void)? = nil) {
        
        // perform request and handle result
        alamofireManager.request(request)
            .validate(statusCode: 200..<300)
            .responseData { response in
                if let error = response.result.error {
                    let doFailure = failure ?? self.handleFailure
                    doFailure(error)
                } else {
                    success?(response.result.value)
                }
        }// closure
    }
    
    
    internal func implementPerform(
        testRequest: URLRequest,
        success: ((Data?) -> Void)?,
        failure: ((Error?) -> Void)? = nil) {
        
        // perform request and handle result
        alamofireManager.request(testRequest)
            .validate(statusCode: 200..<300)
            .responseData { response in
                if let error = response.result.error {
                    let doFailure = failure ?? self.handleFailure
                    
                    print("BaseN: request : \n\(response.request)")
                    print("BaseN: data : \n\(response.result.value)")
                    
                    doFailure(error)
                } else {
                    success?(response.result.value)
                }
        }// closure
    }
    
    
    
    
    internal func handleFailure(_ errorString: Error?) {
        if let error = errorString {
            print("BaseN: error \(error)")
        }
    }
    
    internal func handleFailure(_ errorString: Error?, _ response: DataResponse<String>?) {
        
        if let error = errorString {
            print("BaseN: error \(error)")
        }
        if let responseArray = response {
            print("BaseN: request : \n\(responseArray.request)")
            print("BaseN: data : \n\(responseArray.result.value)")
        }
    }
    
    internal func handleFailure(_ errorString: Error?, _ response: DataResponse<Data>?) {
        
        if let error = errorString {
            print("BaseN: error \(error)")
        }
        if let responseArray = response {
            print("BaseN: request : \n\(responseArray.request)")
            print("BaseN: data : \n\(responseArray.result.value)")
        }
    }    
}
