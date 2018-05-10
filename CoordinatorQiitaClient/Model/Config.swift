//
//  Config.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

struct Config {
    
    struct Key {
        static let authPostBody: String = "qiita_api_auth_body"
    }
    
    struct AuthInfo {
        static let clientId: String = "4351f64ee46f84d8702d18dac8ebe34897b97743"
        static let clientSecret: String = "2891c3bebcceddf67c9ebc8bac7f528c8db2f830"
        static let accessTokenState: String = "F355968FDEB05B26"
        static let redirectUrlScheme: String = "qiita"
    }
    
}

extension Notification.Name {
    
    struct Auth {
        static let CompleteAuthCode: NSNotification.Name = NSNotification.Name(rawValue: "CompleteQiitaAuthCode")
    }
    
}
