//
//  NetworkManager.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation
import Alamofire


open class BaseNetwork {
    
    // create alamofire session manager instance
    internal var alamofireManager = Alamofire.SessionManager()
    
    // create alamofire network reachability instance
    internal var netReachManager: NetworkReachabilityManager?
}

