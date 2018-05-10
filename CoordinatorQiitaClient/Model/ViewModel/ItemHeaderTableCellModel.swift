//
//  ItemHeaderTableCellModel.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/09.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation
import FlowKitManager

struct ItemHeaderTableCellModel: ModelProtocol, Equatable, Hashable {
    
    var identifier: Int
    
    var itemId: String
    var userId: String
    var title: NSAttributedString?
    var tag: String?
    var profileURL: URL?
    var userName: String?
    var likeCount: String?
    var hasLike: Bool
    
    mutating func turnLikeStatus() {
        hasLike = !hasLike
    }
        
}
