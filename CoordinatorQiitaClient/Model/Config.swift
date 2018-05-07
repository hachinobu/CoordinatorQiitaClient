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
        static let clientId: String = "ebdf18cb5ee81b9dd01729375f1350b015484dea"
        static let clientSecret: String = "d141fbb94be0c23551f93d6a071d3c552c92564a"
        static let accessTokenState: String = "F355968FDEB05B26"
        static let redirectUrlScheme: String = "qiita"
    }
    
}

extension Notification.Name {
    
    struct Auth {
        static let CompleteAuthCode: NSNotification.Name = NSNotification.Name(rawValue: "CompleteQiitaAuthCode")
    }
    
}