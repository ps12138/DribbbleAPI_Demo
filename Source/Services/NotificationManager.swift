//
//  NotificationManager.swift
//  opShot_Demo
//
//  Created by PSL on 12/13/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation

public class NotificationManager {
    // MARK: - singleton
    static let sharedInstance = NotificationManager()
    private init () {}
    
    // MARK: - NotificationCenter instance
    internal let center = NotificationCenter.default
    
    
    
    // MARK: - NoticationKeys
    public struct NotiKeys {
        static let kSafariViewControllerCloseNotification =
            NSNotification.Name(rawValue: "kSafariViewControllerCloseNotification")
        static let kAccessTokenEvent = NSNotification.Name(rawValue: "kAccessTokenEvent")
        
        //static let kUpdateAccessToken = NSNotification.Name(rawValue: "kUpdateAccessToken")
    }
    
    // MARK: - addObserver
    public func addObserver(
        safariVCClose receiver: Any,
        aSelector: Selector,
        object: Any?) {
        
        center.addObserver(
            receiver,
            selector: aSelector,
            name: NotiKeys.kSafariViewControllerCloseNotification,
            object: object
        )
    }
    
    public func addObserver(
        accessTokenEvent receiver: Any,
        aSelector: Selector,
        object: Any?) {
        
        center.addObserver(
            receiver,
            selector: aSelector,
            name: NotiKeys.kAccessTokenEvent,
            object: object
        )
    }
    
    
    
    // MARK: - delObserver
    public func removeObserver(
        safariVCClose receiver: Any,
        object: Any?) {
        
        center.removeObserver(
            receiver,
            name: NotiKeys.kSafariViewControllerCloseNotification,
            object: object)
    }
    
    public func removeObserver(
        accessTokenEvent receiver: Any,
        object: Any?) {
        
        center.removeObserver(
            receiver,
            name: NotiKeys.kAccessTokenEvent,
            object: object)
    }
    
    // MARK: - postNotification
    public func post(safariVCClose url: URL) {
        center.post(
            name: NotiKeys.kSafariViewControllerCloseNotification,
            object: url
        )
    }
    public func post(accessTokenEvent status: Bool) {
        center.post(
            name: NotiKeys.kAccessTokenEvent,
            object: status
        )
    }

}

