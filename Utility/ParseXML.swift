//
//  ParseXML.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation
import Fuzi

// MARK: - parse xml to string and hashtag
open class ParseXML {

    // MARK: - parse body <p></p>
    public func parse(richBody comment: String) -> Dictionary<String, AnyObject>? {
        // unvalid XML doc
        guard let doc = try? XMLDocument(
            string: comment,
            encoding: String.Encoding.utf8
            ),
            let root = doc.root
            else {
                return nil
        }
        // unvalid root tag
        if root.tag != xmlConstants.rootTag{
            return nil
        }
        // result Dict
        var result = Dictionary<String, AnyObject>()
        
        // getting body string
        let component = doc.root?.childNodes(ofTypes: [.Text])
        let bodyString = component?.first?.description
        result[xmlConstants.rootTag] = (bodyString ?? "") as AnyObject
        
        // get hashTag
        result[xmlConstants.hashTag] = getHashTag(root: root) as AnyObject
        return result
    }
    
    // MARK: - private method
    private func getHashTag(root: XMLElement) -> Dictionary<String, Int> {
        
        var dict = Dictionary<String, Int>()
        for element in root.children {
            if element.tag != xmlConstants.hashTag {
                continue
            }
            guard let hashTagString = element.childNodes(ofTypes: [.Text]).first?.description,
                let hashTagId = element.attributes[xmlConstants.urlKey]
                else {
                    continue
            }
            if !hashTagId.hasPrefix(xmlConstants.httpsPrefix) {
                continue
            }
            let startIndex = hashTagId.characters.startIndex
            let index = hashTagId.index(startIndex, offsetBy: xmlConstants.httpsPrefixOffet)
            
            let restString = hashTagId.substring(from: index)
            let stringComponent = restString.components(separatedBy: xmlConstants.urlSeperator)
            
            if let idString = stringComponent.last,
                let id = Int(idString) {
                dict[hashTagString] = id
                //print("ParseXml: key: \(hashTagString)")
                //print("ParseXml: id: \(Int(idString))")
            }
        }
        return dict
    }
    
    // MARK: - Constants
    private struct xmlConstants {
        static let rootTag = "p"
        static let hashTag = "a"
        static let urlKey = "href"
        
        static let httpsPrefix = "https://"
        static let httpsPrefixOffet = 8
        static let urlSeperator = "/"
    }
}

