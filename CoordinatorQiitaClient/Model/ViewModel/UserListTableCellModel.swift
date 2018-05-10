//
//  UserListTableCellModel.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/10.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation
import FlowKitManager

struct UserListTableCellModel: ModelProtocol, Equatable, Hashable {
    
    var identifier: Int
    
    var userId: String
    var userName: String
    var profileURL: URL?
    
}
