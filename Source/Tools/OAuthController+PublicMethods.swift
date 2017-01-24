//
//  OAuthController+publicMethods.swift
//  DribbbleAPI_Demo
//
//  Created by PSL on 1/23/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation

// MARK: - Public Methods
extension OAuthController {
    
    // MARK: - OAuth2 flow
    
    /// step1: create URL for OAuth2
    public func fetchLoginUrl() -> URL? {
        return URLToStartOAuth2Login()
    }
    
    /// Step2: using the OAuth2 URL to login and auth
    /// out of this class
    
    /// Step3: get the call back URL and request Token
    public func processCallbackUrl(url: URL) {
        processOAuthResponseCallBackURL(url: url)
    }
    
    
    
    // MARK: - key related methods
    
    
    
    
    /// get OAuth callback scheme
    public var callBackScheme: String {
        return Constants.callBackPrefix
    }
    
    /// mark, we are requesting Token
    public func markRequestingToken() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: Constants.markRequestingToken)
    }
    
    /// mark, we have done the Token requesting
    public func clearMarkRequestingToken() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: Constants.markRequestingToken)
    }
    
    // check, whether we are requesting a Token
    public func checkRequestingToken() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: Constants.markRequestingToken)
    }
    
    /// check and perform known Token
    public func performKnownToken() -> Bool {
        if hasOAuthToken() {
            delegate?.updateToken(token: accessToken)
            return true
        }
        return false
    }
    
    /// validation OAuth token
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
    
    /// use public oauth Token
    public func usePublicAccessToken() {
        implementUsePublicAccessToken()
    }
    
    /// clear oauth Token
    public func clearOAuthToken() {
        if accessToken != nil {
            accessToken = nil
        }
        baseNetwork.updateToken(nil)
    }
}
