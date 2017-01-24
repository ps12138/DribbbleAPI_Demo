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
    private init () {
        oauthController.delegate = self
    }
    
    // MARK: - create alamofire session manager
    internal let baseNetwork = BaseNetwork()
    internal let oauthController = OAuthController()
    internal let parseJson = ParseJson()
    
    /// Net status
    internal var networkStatusInternal: NetworkReachability = NetworkReachability.unknown
    
    // MARK: - Constants
    internal struct Constants {
        static let reachToDribble = "https://api.dribbble.com"
        static let reachToGoogle = "https://www.google.com"
    }
}
