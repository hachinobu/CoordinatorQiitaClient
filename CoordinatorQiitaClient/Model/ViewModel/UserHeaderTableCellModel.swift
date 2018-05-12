//
//  UserHeaderlTableCellModel.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/10.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation
import FlowKitManager

struct UserHeaderTableCellModel: ModelProtocol, Equatable, Hashable {
    
    var identifier: Int
    
    var profileURL: URL?
    var userId: String
    var userName: String?
    var company: String?
    var itemCount: String?
    var followeeUserCount: String?
    var followerUserCount: String?
    var description: NSAttributedString?
}
