//
//  ItemContentsTableCellModel.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/09.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation
import FlowKitManager

struct ItemContentsTableCellModel: ModelProtocol, Equatable, Hashable {
    
    var identifier: Int
    
    var htmlBody: String
    
}
