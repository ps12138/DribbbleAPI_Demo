//
//  KeyChainManager.swift
//  DribbbleModuleFramework
//
//  Created by PSL on 12/7/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation
import Locksmith

// MARK: - lock smith encapulation
class KeyChainManager {
    static let sharedInstance = KeyChainManager()
    private init() {}
    
    //when keychain has a value, if we use Locksmith.saveData to update keychian, we will be thrown by an exception
    func saveData(data: [String: Any], forUserAccount userAccount: String) throws {
        try saveData(data: data, forUserAccount: userAccount)
    }
    
    func loadDataForUserAccount(userAccount: String) -> [String: Any]? {
        return Locksmith.loadDataForUserAccount(userAccount: userAccount)
    }
    
    func deleteDataForUserAccount(userAccount: String ) throws {
        try Locksmith.deleteDataForUserAccount(userAccount: userAccount)
    }
    
    func updateData(data: [String: Any], forUserAccount userAccount: String
        ) throws {
        try Locksmith.updateData(data: data, forUserAccount: userAccount)
    }
}
