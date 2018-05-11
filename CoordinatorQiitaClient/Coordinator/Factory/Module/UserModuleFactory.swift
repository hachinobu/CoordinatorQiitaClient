//
//  UserModuleFactory.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/10.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol UserModuleFactory {
    func generateLikeUserListView(with itemId: String) -> UserListViewOutput
    func generateFolloweeUserListView(with userId: String) -> UserListViewOutput
    func generateFollowerUserListView(with userId: String) -> UserListViewOutput
    func generateUserDetailView(with userId: String) -> UserDetailViewOutput
}
