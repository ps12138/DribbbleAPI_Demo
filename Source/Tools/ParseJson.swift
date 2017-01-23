//
//  ParseJson.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol ParseJsonInterface {
    func parse(listShot receivedData: Data?) -> [ShotBlock]
    func parse(userLikes receivedData: Data?) -> [ShotBlock]
    func parse(sessionid receivedData: Data?) -> Int?
    func parse(sessionidMapToshotid receivedData: Data?) -> Dictionary<Int, Int>?
    func parse(user receivedData: Data?) -> User?
    func parse(comments receivedData: Data?) -> [Comment]
    func parse(comment receivedData: Data?) -> Comment?
}


// MARK: - parse Json to Model
struct ParseJson: ParseJsonInterface {
    // MARK: - Public API
    public func parse(listShot receivedData: Data?) -> [ShotBlock] {
        return implement(parseToShotBlocks: receivedData)
    }
    
    public func parse(userLikes receivedData: Data?) -> [ShotBlock] {
        return implement(parseUserLikesToShotBlocks: receivedData)
    }
    
    public func parse(sessionid receivedData: Data?) -> Int? {
        return implement(parseSessionid: receivedData)
    }
    
    public func parse(sessionidMapToshotid receivedData: Data?) -> Dictionary<Int, Int>? {
        return implement(parseSessionidMapToShotid: receivedData)
    }
    
    public func parse(user receivedData: Data?) -> User? {
        return implement(parseUser: receivedData)
    }
    
    public func parse(comments receivedData: Data?) -> [Comment] {
        return implement(parseComments: receivedData)
    }
    
    public func parse(comment receivedData: Data?) -> Comment? {
        return implement(parseComment: receivedData)
    }
    
    // MARK: - internal instance
    internal let parseXML = ParseXML()
}
