//
//  NetworkManager+publicRawRequest.swift
//  opShot_Demo
//
//  Created by PSL on 12/14/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation

extension NetworkManager {
    
    // MARK: - form request for given path
    public func formRequest(_ method: String, urlString: String) -> URLRequest? {
        
        // form url
        guard let url = URL(string: "\(urlString)") else {
            print("NetM.perfromR: unvalid urlString")
            return nil
        }
        var request = URLRequest(url: url)
        
        // form httpmethod
        request.httpMethod = method
        
        // form paramters
        print("NetM.perfromR: form request url: \(request.url!)")
        return request
    }
    
    
    public func performTestRequest(
        customRequest request: URLRequest,
        failure: ((Error?) -> Void)? = nil,
        success: ((Data?) -> Void)?
    ) {
        print("NetM.perfromR: customRequest")
        baseNetwork.perform(
            testRequest: request,
            success: success
        )
    }
}
