//
//  DeepLinkOption.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/10.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

enum DeepLinkOption {
    case likeUserList(String)
    
    func fetchLikeUserListItemId() -> String? {
        switch self {
        case .likeUserList(let id):
            return id
        default:
            return nil
        }
    }
}
