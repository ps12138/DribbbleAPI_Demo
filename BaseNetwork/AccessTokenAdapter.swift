//
//  AccessTokenAdapter.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - auto using adapter to add access token
class AccessTokenAdapter: RequestAdapter {
    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        // 64base encryption
        //let credentialData = accessToken.data(using: String.Encoding.utf8)!
        //let base64Credentials = credentialData.base64EncodedString(options: [])
        
        // dribbble not need to encrypt body
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
