//
//  OAuthController.swift
//  DribbbleAPI_Demo
//
//  Created by PSL on 1/23/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation


protocol OAuthControllerDelegate: class {
   func updateToken(token: String?)
}


class OAuthController {
    
    // MARK: - create alamofire session manager
    internal let baseNetwork = BaseNetwork()
    internal weak var delegate: OAuthControllerDelegate? = nil
    
    // MARK: Key related
    internal struct Constants {
        static let AccessTokenKey = "dribbble_oauth2"
        static let markRequestingToken = "loadingOAuthToken"
        static let callBackPrefix = "driapicallback"
    }
    
    // MARK: - calculate properties
    
    /// create accessToken
    internal var accessToken: String? {
        set {
            // if newValue is valid
            if let valueToSave = newValue {
                do {
                    // lets update it
                    print("KeyChain: update accessToken")
                    try KeyChainManager.sharedInstance.updateData(data: ["token": valueToSave], forUserAccount: Constants.AccessTokenKey)
                } catch {
                    print("KeyChain: fail to save the key")
                    // if fail to update, we delete it
                    let _ = try? KeyChainManager.sharedInstance.deleteDataForUserAccount(userAccount: Constants.AccessTokenKey)
                }
            } else {
                // they set it to nil, so delete it
                let _ = try? KeyChainManager.sharedInstance.deleteDataForUserAccount(userAccount: Constants.AccessTokenKey)
                print("KeyChain: clear accessToken")
                //print("KeyChain: Re-request accessToken")
                //requestOAuth2();
            }
        }
        
        get {
            // try to load from keychain
            let dictionary = KeyChainManager.sharedInstance.loadDataForUserAccount(userAccount: Constants.AccessTokenKey)
            if let token = dictionary?["token"] as? String {
                print("KeyChain: retrived key")
                return token
            }
            return nil
        }
    }

}
