//
//  DeepLinkOption.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/10.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

enum DeepLinkOption {
    case itemDetail(String)
    case likeUserList(String)
    case followeeUserList(String)
    case followerUserList(String)
    case userDetail(String)
    case userFollowTag(String)
    case tagItemList(String)
    
    func fetchItemDetailItemId() -> String? {
        switch self {
        case .itemDetail(let id):
            return id
        default:
            return nil
        }
    }
    
    func fetchLikeUserListItemId() -> String? {
        switch self {
        case .likeUserList(let id):
            return id
        default:
            return nil
        }
    }
    
    func fetchFolloweeUserListUserId() -> String? {
        switch self {
        case .followeeUserList(let id):
            return id
        default:
            return nil
        }
    }
    
    func fetchFollowerUserListUserId() -> String? {
        switch self {
        case .followerUserList(let id):
            return id
        default:
            return nil
        }
    }
    
    func fetchUserId() -> String? {
        switch self {
        case .userDetail(let id):
            return id
        default:
            return nil
        }
    }
    
    func fetchFollowTagUserId() -> String? {
        switch self {
        case .userFollowTag(let id):
            return id
        default:
            return nil
        }
    }
    
    func fetchTagItemListTagId() -> String? {
        switch self {
        case .tagItemList(let id):
            return id
        default:
            return nil
        }
    }
    
}
