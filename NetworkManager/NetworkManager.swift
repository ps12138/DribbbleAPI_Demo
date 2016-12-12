//
//  NetworkManager.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation


public class NetworkManager {
    // MARK: - singleton
    static let sharedInstance = NetworkManager()
    private init () {}
    
    // MARK: - create alamofire session manager
    internal let baseNetwork = BaseNetwork()
    internal let parseJson = ParseJson()
    
    // net status
    internal var networkStatusInternal: NetworkReachability = NetworkReachability.unknown
    
    // MARK: Key related
    internal struct KeyChainUserAccount {
        static let OAuth2AccessToken = "dribbble_oauth2"
        
    }
    
    internal struct Constants {
        static let markRequestingToken = "loadingOAuthToken"
        static let apiBase = "https://api.dribbble.com"
    }
}
