//
//  ItemListTableCellModel.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/08.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation
import FlowKitManager

struct ItemListTableCellModel: ModelProtocol, Equatable, Hashable {
    var identifier: Int
    
    var itemId: String
    var userId: String
    var profileURL: URL?
    var userName: String?
    var likeCount: String?
    var title: NSAttributedString?
    var tag: String?
}
