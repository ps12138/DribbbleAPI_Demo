//
//  NetworkManager+publicDataExchange.swift
//  DribbbleModuleFrameworkShadow
//
//  Created by PSL on 12/11/16.
//  Copyright © 2016 PSL. All rights reserved.
//

import Foundation

extension NetworkManager {
    // MARK: - download with progress
    public func perform(
        downloadFrom url: String,
        progress progressCallBack: ((Double) -> Void)? = nil,
        data dataCallBack: ((Data?) -> Void)?
        ) {
        baseNetwork.perform(
            downloadFrom: url,
            progress: progressCallBack,
            data: dataCallBack
        )
    }
    
    // MARK: - download with qos progress
    public func perform(
        downloadFrom url: String,
        qosProgress progressCallBack: ((Double) -> Void)? = nil,
        data dataCallBack: ((Data?) -> Void)?
        ) {
        baseNetwork.perform(
            downloadFrom: url,
            progressInQos: progressCallBack,
            data: dataCallBack
        )
    }

}
