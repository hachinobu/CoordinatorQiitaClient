//
//  TagListTableCellModel.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/11.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation
import FlowKitManager

struct TagListTableCellModel: ModelProtocol, Equatable, Hashable {
    
    var identifier: Int
    
    var tagId: String
    var tagName: String
    var tagImageURL: URL?
    var tagCountInfo: String
}
