//
//  NetworkManager+Reachability.swift
//  DribbbleModuleFrameworkShadow
//
//  Created by PSL on 12/8/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation

// MARK: - Network Reachability
extension NetworkManager {
    
    // AMRK: - api for current net status
    public var networkStatus: NetworkReachability {
        return networkStatusInternal
    }
    
    
    // MARK: - Network Reachability Manager
    public func startReachListener() {
        let urlString = Constants.reachToDribble
        baseNetwork.startReachListener(
            host: urlString,
            callBack: handleNetworkStatus
        )
    }
    
    public func stopReachListener() {
        baseNetwork.stopReachListener()
    }
    
    // MARK: - private methods
    private func handleNetworkStatus(status: NetworkReachability) {
        networkStatusInternal = status
    }
    
    
    
    
    
}
