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
    func generateTabView(with selected: TabbarController.SelectTab) -> TabViewOutput {
        let view = TabbarController(tab: selected)
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
