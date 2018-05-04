//
//  AuthenticationInfo.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/05.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

struct Auth {
    
    struct PostBody: Codable {
        let clientId: String
        let clientSecret: String
        let code: String
    }
    
    struct AccessTokenInfo: Codable {
        let clientId: String
        let scopes: [String]
        let token: String
    }
    
}
