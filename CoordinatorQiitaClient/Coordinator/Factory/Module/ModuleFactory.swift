//
//  ModuleFactory.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

final class ModuleFactory {}

extension ModuleFactory: AuthModuleFactory {
    func generateLoginView() -> LoginViewOutput {
        let view = AuthViewController()
        return view
    }
}

extension ModuleFactory: TabModuleFactory {
    
    func generateTabView(with selected: TabbarController.SelectTab,
                         itemTabHandler: @escaping ((UINavigationController) -> Void),
                         tagTabHandler: @escaping ((UINavigationController) -> Void),
                         mypageTabHandler: @escaping ((UINavigationController) -> Void)) -> TabViewOutput {
        let view = TabbarController(tab: selected, selectedItemTabHandler: itemTabHandler, selectedTagTabHandler: tagTabHandler, selectedMypageTabHandler: mypageTabHandler)
        return view
    }
    
}

extension ModuleFactory: ItemModuleFactory {
    func generateItemListView() -> ItemListViewOutput {
        let view = ItemListViewController(title: "投稿一覧")
        return view
    }
    
    func generateItemDetailView(itemId: String) -> ItemDetailViewOutput {
        let view = ItemDetailViewController(title: "詳細", itemId: itemId)
        return view
    }
}

extension ModuleFactory: UserModuleFactory {
    func generateLikeUserListView(with itemId: String) -> UserListViewOutput {
        let view = LikeUserListViewController(title: "いいねした人", itemId: itemId)
        return view
    }
    
    func generateFolloweeUserListView(with userId: String) -> UserListViewOutput {
        let view = FolloweeListViewController(title: "フォローしている人", userId: userId)
        return view
    }
    
    func generateFollowerUserListView(with userId: String) -> UserListViewOutput {
        let view = FollowerListViewController(title: "フォローされている人", userId: userId)
        return view
    }
    
    func generateUserDetailView(with userId: String) -> UserDetailViewOutput {
        let view = UserDetailViewController(title: userId, userId: userId)
        return view
    }
    
}
