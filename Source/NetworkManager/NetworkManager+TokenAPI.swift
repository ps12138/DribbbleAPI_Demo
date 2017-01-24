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
    /// step1: create URL for OAuth2
    public func fetchLoginUrl() -> URL? {
        return oauthController.URLToStartOAuth2Login()
    }
    
    /// Step2: using the OAuth2 URL to login and auth
    /// out of this class
    
    /// Step3: get the call back URL and request Token
    public func processCallbackUrl(url: URL) {
        oauthController.processOAuthResponseCallBackURL(url: url)
    }
    
    
    // MARK: - key related methods
    
    /// get OAuth callback scheme
    public var callBackScheme: String {
        return oauthController.callBackScheme
    }
    
    /// mark, we are requesting Token
    public func markRequestingToken() {
        oauthController.markRequestingToken()
    }
    
    /// mark, we have done the Token requesting
    public func clearMarkRequestingToken() {
        oauthController.clearMarkRequestingToken()
    }
    
    /// check, whether we are requesting a Token
    public func checkRequestingToken() -> Bool {
        return oauthController.checkRequestingToken()
    }
    
    /// validation OAuth token
    public func hasOAuthToken() -> Bool {
        return oauthController.hasOAuthToken()
    }
    
    /// check and use known Token
    public func performKnownToken() -> Bool {
        return oauthController.performKnownToken()
    }
    
    /// use public oauth Token
    public func usePublicAccessToken() {
        oauthController.usePublicAccessToken()
    }
    
    /// clear oauth Token
    public func clearOAuthToken() {
        oauthController.clearOAuthToken()
        baseNetwork.updateToken(nil)
    }
}

// MARK: - conform OAuthControllerDelegate
extension NetworkManager: OAuthControllerDelegate {
    internal func updateToken(token: String?) {
        baseNetwork.updateToken(token)
    }
}




