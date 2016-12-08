//
//  ParseJson+internalMethod.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - internal methods
extension ParseJson {
    
    internal func implement(parseToShotBlocks receivedData: Data?) -> [ShotBlock] {
        
        var shotBlocks = [ShotBlock]()
        guard let absoluteData = receivedData else {
            return shotBlocks
        }
        
        let json = try! JSONSerialization.jsonObject(with: absoluteData, options: JSONSerialization.ReadingOptions.mutableLeaves)
        
        guard let jsonArray = json as? Array<AnyObject> else {
            print("ParseJson: fails on json -> Array")
            return shotBlocks
        }
        print("ParseJson: ready to read \(jsonArray.count)")
        for row in jsonArray {
            if let dict = row as? Dictionary<String, AnyObject> {
                // convert to obj
                if let newBlock = ShotBlock(dict: dict) {
                    // process desc String
                    if let parsedDescBodyDict = parseXML.parse(richBody: newBlock.desc) {
                        newBlock.translateDescBody(dict: parsedDescBodyDict)
                    }
                    shotBlocks.append(newBlock)
                }
            }
        }
        return shotBlocks
    }
    
    
    internal func implement(parseUserLikesToShotBlocks receivedData: Data?) -> [ShotBlock] {
        var shotBlocks = [ShotBlock]()
        
        guard let absoluteData = receivedData else {
            return shotBlocks
        }
        
        let json = try! JSONSerialization.jsonObject(with: absoluteData, options: JSONSerialization.ReadingOptions.mutableLeaves)
        
        guard let jsonArray = json as? Array<AnyObject> else {
            print("ParseJson: fails on json -> Array")
            return shotBlocks
        }
        
        print("ParseJson: ready to read \(jsonArray.count)")
        parseArray(toBlocks: jsonArray, shotBlocks: &shotBlocks)
        return shotBlocks
    }
    
    
    private func parseArray(toBlocks array: Array<AnyObject>, shotBlocks: inout [ShotBlock]) {
        //var shotBlocks = [ShotBlock]()
        for row in array {
            
            // layer of id create_at shot
            guard let sessionDict = row as? Dictionary<String, AnyObject>,
                let dict = sessionDict["shot"] as? Dictionary<String, AnyObject>
                else {
                    continue
            }
            
            // layer of shot itself
            if let newBlock = ShotBlock(dict: dict) {
                // process desc String
                if let parsedDescBodyDict = parseXML.parse(richBody: newBlock.desc) {
                    newBlock.translateDescBody(dict: parsedDescBodyDict)
                }
                shotBlocks.append(newBlock)
            }
        }
    }
    
    
    internal func implement(parseSessionid receivedData: Data?) -> Int? {
        
        guard let absoluteData = receivedData else {
            return nil
        }
        
        let json = SwiftyJSON.JSON(data: absoluteData)
        var id: Int?
        for (key, value) in json {
            switch key {
            case "id":
                print("POST: ID = \(value)")
                id = value.int
            case "created_at":
                print("POST: created_at = \(value)")
            default:
                print("Notice: more than I need = \(key)")
            }
        }
        return id
    }
    
   internal func implement(parseSessionidMapToShotid receivedData: Data?) -> Dictionary<Int, Int>? {
        guard let absoluteData = receivedData else {
            return nil
        }
        
        guard let jsons = SwiftyJSON.JSON(data: absoluteData).array else {
            return nil
        }
        // <shotId, sessionId>
        var result = Dictionary<Int, Int>()
        for json in jsons {
            if let shotId = json["shot"]["id"].int,
                let sessionId = json["id"].int {
                result[shotId] = sessionId
            }
        }
        return result
    }
    
    
    internal func implement(parseUser receivedData: Data?) -> User? {
        guard let absoluteData = receivedData else {
            return nil
        }
        let json = try! JSONSerialization.jsonObject(with: absoluteData, options: JSONSerialization.ReadingOptions.mutableLeaves)
        
        if let dict = json as? Dictionary<String, AnyObject> {
            //print("ParseJson: create dict")
            if let user = User(dict: dict) {
                //print("ParseJson: creat shot blcoks")
                return user
            }
        }
        return nil
    }
    
    
    internal func implement(parseComments receivedData: Data?) -> [Comment] {
        
        var results = [Comment]()
        guard let absoluteData = receivedData else {
            return results
        }
        let json = try! JSONSerialization.jsonObject(with: absoluteData, options: JSONSerialization.ReadingOptions.mutableLeaves)
        
        guard let jsonArray = json as? Array<AnyObject> else {
            return results
        }
        
        for jsonElement in jsonArray {
            if let dict = jsonElement as? Dictionary<String, AnyObject> {
                if let newComment = Comment(dict:dict) {
                    if let parsedBodyDict = parseXML.parse(richBody: newComment.body) {
                        newComment.translateBody(dict: parsedBodyDict)
                    }
                    results.append(newComment)
                }
            }
        }
        return results
    }
    
    
    func implement(parseComment receivedData: Data?) -> Comment? {
        guard let absoluteData = receivedData else {
            return nil
        }
        let json = try! JSONSerialization.jsonObject(with: absoluteData, options: JSONSerialization.ReadingOptions.mutableLeaves)
        
        if let dict = json as? Dictionary<String, AnyObject> {
            //print("ParseJson: create dict")
            if let newComment = Comment(dict: dict) {
                if let parsedBodyDict = parseXML.parse(richBody: newComment.body) {
                    newComment.translateBody(dict: parsedBodyDict)
                }
                return newComment
            }
        }
        return nil
        
    }

}
