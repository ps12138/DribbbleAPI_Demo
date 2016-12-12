//
//  NetworkReachability.swift
//  DribbbleModuleFrameworkShadow
//
//  Created by PSL on 12/8/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation

public enum NetworkReachability {
    case unknown
    case offline
    case online(NetworkOnlineType)
}

public enum NetworkOnlineType {
    case unknown
    case wifi
    case cell
}
