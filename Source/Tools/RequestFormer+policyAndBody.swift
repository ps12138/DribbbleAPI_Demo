//
//  RequestFormer+HTTPBody.swift
//  DribbbleAPI_Demo
//
//  Created by PSL on 1/22/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation

// MARK: - form HTTP body and CachePolicy
extension RequestFormer {
    
    /// add http body
    internal func formHttpBody(_ from: DribbleAPIBase) -> Data? {
        switch from {
        case .createComment( _, let content):
            return formBody(bodyString: content)
        default:
            return nil
        }
    }
    
    // form given body
    private func formBody(bodyString: String) -> Data? {
        
        let dict = ["body": bodyString]
        let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
        return data
    }

    
    
    /// add custom CachePolicy for given request
    internal func formCachePolicy(_ from: DribbleAPIBase) -> URLRequest.CachePolicy {
        switch from {
        case .activeUser:
            return URLRequest.CachePolicy.reloadIgnoringCacheData
        default:
            return URLRequest.CachePolicy.useProtocolCachePolicy
        }
    }

}
