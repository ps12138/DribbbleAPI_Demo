//
//  Network+OAuth2.swift
//  DribbbleModuleFrameworkShadow
//
//  Created by PSL on 12/8/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - OAuth2 flow
extension NetworkManager {

    // MARK: - OAuth request begin
    public func markRequestingToken() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: Constants.markRequestingToken)
    }
    
    public func clearMarkRequestingToken() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: Constants.markRequestingToken)
    }
    
    // MARK: - Check whether we have OAuth Token
    public func hasOAuthToken() -> Bool {
        // TODO: implement
        guard let token = accessToken else{
            return false
        }
        if token.isEmpty {
            return false
        }
        return true
    }
    
    public func clearOAuthToken() {
        if accessToken != nil {
            accessToken = nil
        }
    }

    
    
    
    
    // MARK: - OAuth2 flow
    public func URLToStartOAuth2Login() -> NSURL? {
        let authPath = "\(OAuth2Constants.oauthLogin)?client_id=\(OAuth2Constants.clientID)&scope=\(OAuth2Constants.scope)"
        guard let authURL:NSURL = NSURL(string: authPath) else {
            // url: handle error
            print("NetM.OAuth2: wrong Oauth url")
            assert(true)
            return nil
        }
        return authURL
    }
    
    
    
    // handle call back url
    public func processOAuthResponseCallBackURL(url: URL) {
        // format of we get the call back
        print("NetM.OAuth2: CallBack, URL")
        
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
            print("NetM.OAuth2: Code: got")
            requestToken(withCode: receivedCode)
        } else {
            print("NetM.OAuth2: No code")
            clearMarkRequestingToken()
            // TODO: retry login
        }
        
    }
    
    
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
    
    private func handleSuccessRequestToken(_ value: String?) {
        //print(response.result.value)
        if let receivedResults = value,
            let jsonData = receivedResults.data(
                using: String.Encoding.utf8,
                allowLossyConversion: false
            ) {
            
            let jsonResults = JSON(data: jsonData)
            for (key, value) in jsonResults {
                switch key {
                case "access_token":
                    print("GET: AccessToken")
                    self.accessToken = value.string
                case "scope":
                    // TODO: verify scope
                    print("SET: SCOPE = \(value)")
                    if value.description != OAuth2Constants.scope {
                        break
                    }
                case "token_type":
                    // TODO: verify is bearer
                    print("GET: BEARER = \(value)")
                    if value.description != OAuth2Constants.bearer {
                        break
                    }
                case "created_at":
                    print("GET: created_at = \(value)")
                default:
                    print("Notice: more keys = \(key)")
                }
            }
        }
        // finished loading Token
        clearMarkRequestingToken()
        
        if (hasOAuthToken()) {
            //self.printUser()
            baseNetwork.updateToken(accessToken)
            //ActiveUser.sharedInstance.getActiveUser()
        } else {
            // TODO: handle no OAuth
            // TODO: test reachability to retry or keep offline
        }
        
    }
    
    private func handleFailRequestToken(_ error: Error?, value: String?) {
        if let errorString = error {
            print("Error: request token \(errorString)")
        }
        if let receivedString = value {
            print("Received: \(receivedString)")
        }
        // TODO: auto retry
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
    
    // MARK: - constants for OAuth2
    fileprivate struct OAuth2Constants {
        
        // client key pair
        static let clientID = "6945370a2e285efd2e79515a61fc0dc630c0ba98667212ae1ff5591596518bf5"
        static let clientSecret = "90c086a8473070e7a8932b88991012e06c84d411e9c9c80079a09a353cc28699"
        
        // callBack prefix
        static let callBackPrefix = ""
        
        // auth API url
        static let requestToken = "https://dribbble.com/oauth/token"
        // OAuth login url
        static let oauthLogin = "https://dribbble.com/oauth/authorize"
        
        static let scope = "public+write"
        static let bearer = "bearer"
    }


    
}
