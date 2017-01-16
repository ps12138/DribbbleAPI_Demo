//
//  NetworkManager+publicAPI.swift
//  opShot_Demo
//
//  Created by PSL on 12/16/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation


// MARK: - public methods
extension NetworkManager {
    
    // MARK: - OAuth callback scheme
    public var callBackScheme: String {
        return Scheme.callBackPrefix
    }
    
    // MARK: - OAuth request begin
    public func markRequestingToken() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: Constants.markRequestingToken)
    }
    
    public func clearMarkRequestingToken() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: Constants.markRequestingToken)
    }
    
    public func checkRequestingToken() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: Constants.markRequestingToken)
    }
    
    // MARK: - Check whether we have OAuth Token
    public func tryLoadToken() {
        if hasOAuthToken() {
            baseNetwork.updateToken(accessToken)
        }
    }
    
    
    public func hasOAuthToken() -> Bool {
        // did: implement
        guard let token = accessToken else{
            return false
        }
        if token.isEmpty {
            return false
        }
        return true
    }
    
    public func usePublicAccessToken() {
        implementUsePublicAccessToken()
    }
    
    
    public func clearOAuthToken() {
        if accessToken != nil {
            accessToken = nil
        }
        baseNetwork.updateToken(nil)
    }

    
    
    // create accessToken
    public var accessToken: String? {
        set {
            // if newValue is valid
            if let valueToSave = newValue {
                do {
                    // lets update it
                    print("KeyChain: update accessToken")
                    try KeyChainManager.sharedInstance.updateData(data: ["token": valueToSave], forUserAccount: KeyChainUserAccount.OAuth2AccessToken)
                } catch {
                    print("KeyChain: fail to save the key")
                    // if fail to update, we delete it
                    let _ = try? KeyChainManager.sharedInstance.deleteDataForUserAccount(userAccount: KeyChainUserAccount.OAuth2AccessToken)
                }
            } else {
                // they set it to nil, so delete it
                let _ = try? KeyChainManager.sharedInstance.deleteDataForUserAccount(userAccount: KeyChainUserAccount.OAuth2AccessToken)
                print("KeyChain: clear accessToken")
                //print("KeyChain: Re-request accessToken")
                //requestOAuth2();
            }
        }
        
        get {
            // try to load from keychain
            let dictionary = KeyChainManager.sharedInstance.loadDataForUserAccount(userAccount: KeyChainUserAccount.OAuth2AccessToken)
            if let token = dictionary?["token"] as? String {
                print("Action: retrived key")
                return token
            }
            return nil
        }
    }

}
