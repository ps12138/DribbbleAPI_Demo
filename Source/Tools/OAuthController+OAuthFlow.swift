//
//  OAuthController+InternalMethods.swift
//  DribbbleAPI_Demo
//
//  Created by PSL on 1/23/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import Foundation
import SwiftyJSON // TODO: decoupling swiftyJson


// MARK: - OAuth2 flow
extension OAuthController {
    
    /// step1: create URL for OAuth2
    internal func URLToStartOAuth2Login() -> URL? {
        let authPath = "\(OAuth2Constants.oauthLogin)?client_id=\(OAuth2Constants.clientID)&scope=\(OAuth2Constants.scope)"
        guard let authURL: URL = URL(string: authPath) else {
            // url: handle error
            print("OAuth.C: wrong Oauth url")
            assert(true)
            return nil
        }
        return authURL
    }
    
    /// Step2: using the OAuth2 URL to login and auth
    /// out of this class
    
    /// Step3: get the call back URL and request Token
    internal func processOAuthResponseCallBackURL(url: URL) {
        // format of we get the call back
        print("OAuth.C: CallBack, URL")
        
        // parse URL into parts to get "code"
        let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
        var code:String?
        if let queryItems = components?.queryItems {
            for queryItem in queryItems {
                if (queryItem.name.lowercased() == "code") {
                    code = queryItem.value
                    break
                }
            }
        }
        // send code back to swap Token
        // send .post with code, clientID, clientSecret
        if let receivedCode = code {
            print("OAuth.C: Code: got")
            requestToken(withCode: receivedCode)
        } else {
            print("OAuth.C: No code")
            //clearMarkRequestingToken()
            // TODO: retry login
            
            // Did: post accessToken notification
            NotificationManager.sharedInstance.post(accessTokenEvent: false)
        }
        
    }
    
    // ------------------------------------------------------------
    
    // MARK: - internal methods
    internal func implementUsePublicAccessToken() {
        accessToken = OAuth2Constants.publicToken
        delegate?.updateToken(token: accessToken)
    }
    
    
    // MARK: - private methods
    // MARK: request access token with code
    private func requestToken(withCode receivedCode: String) {
        
        let tokenParams = [
            "client_id": OAuth2Constants.clientID,
            "client_secret": OAuth2Constants.clientSecret,
            "code": receivedCode
        ]
        let jsonHeader = ["Authorization": "application/json"]
        baseNetwork.perform(
            postTo: OAuth2Constants.requestToken,
            parameters: tokenParams,
            headers: jsonHeader,
            success: handleSuccessRequestToken,
            failure: handleFailRequestToken
        )
    }
    
    // MARK: - handle success
    private func handleSuccessRequestToken(_ value: String?) {
        //print(response.result.value)
        if let receivedResults = value,
            let jsonData = receivedResults.data(
                using: String.Encoding.utf8,
                allowLossyConversion: false
            ) {
            
            let jsonResults = SwiftyJSON.JSON(data: jsonData)
            for (key, value) in jsonResults {
                switch key {
                case "access_token":
                    print("OAuth.C: GET: AccessToken")
                    self.accessToken = value.string
                case "scope":
                    // TODO: verify scope
                    print("OAuth.C: SET: SCOPE = \(value)")
                    if value.description != OAuth2Constants.scope {
                        break
                    }
                case "token_type":
                    // TODO: verify is bearer
                    print("OAuth.C: GET: BEARER = \(value)")
                    if value.description != OAuth2Constants.bearer {
                        break
                    }
                case "created_at":
                    print("OAuth.C: GET: created_at = \(value)")
                default:
                    print("OAuth.C: warning more keys = \(key)")
                }
            }
        }
        // finished loading Token
        //clearMarkRequestingToken()
        
        if (hasOAuthToken()) {
            //self.printUser()
            //baseNetwork.updateToken(accessToken)
            // trying to update accessToken
            delegate?.updateToken(token: self.accessToken)
            NotificationManager.sharedInstance.post(accessTokenEvent: true)
        } else {
            // TODO: handle no OAuth
            // TODO: test reachability to retry or keep offline
            
            // Did: post accessToken notification
            NotificationManager.sharedInstance.post(accessTokenEvent: false)
        }
        
    }
    
    // MARK: - handle fail
    private func handleFailRequestToken(_ error: Error?, value: String?) {
        if let errorString = error {
            print("OAuth.C: error: request token \(errorString)")
        }
        if let receivedString = value {
            print("OAuth.C: received: \(receivedString)")
        }
        // Did: post accessToken notification
        NotificationManager.sharedInstance.post(accessTokenEvent: false)
        
        // TODO: auto retry
    }
    
    // MARK: - constants for OAuth2
    fileprivate struct OAuth2Constants {
        
        // client key pair
        static let clientID = "6945370a2e285efd2e79515a61fc0dc630c0ba98667212ae1ff5591596518bf5"
        static let clientSecret = "90c086a8473070e7a8932b88991012e06c84d411e9c9c80079a09a353cc28699"
        static let publicToken = "37ddfc23b82ae5cfc673bc92770caf17272407d0d07bce3c1840fc993a509667"
        
        // auth API url
        static let requestToken = "https://dribbble.com/oauth/token"
        // OAuth login url
        static let oauthLogin = "https://dribbble.com/oauth/authorize"
        
        static let scope = "public+write"
        static let bearer = "bearer"
    }

}
