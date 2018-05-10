//
//  ItemCoordinator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/08.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

final class ItemCoordinator: BaseCoordinator, CoordinatorFinishFlowType {
    
    var finishFlow: (() -> Void)?
    
    private let moduleFactory: ItemModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(moduleFactory: ItemModuleFactory, coordinatorFactory: CoordinatorFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    override func start() {
        showItemList()
    }
    
    private func showItemList() {
        
        let view = moduleFactory.generateItemListView()
        
        view.selectedItemHandler = { [weak self] itemId in
            self?.showItemDetail(with: itemId)
        }
        
        view.selectedUserHandler = { [weak self] userId in
            print(userId)
        }
        
        router.setRoot(view, hideBar: false)

    }
    
    private func showItemDetail(with itemId: String) {
        let view = moduleFactory.generateItemDetailView(itemId: itemId)
        
        view.selectedUserHandler = { [weak self] id in
            print("selectUser")
        }
        
        view.selectedLikeHandler = { [weak self] in
            if UserDefaults.StringType.value(key: .accessToken).isEmpty {
                return false
            } else {
                return true
            }
        }
        
        view.selectedLikeCountHandler = { [weak self] in
            print("selectCount")
        }
        
        router.push(view, animated: true, completion: nil)
        
    }
    
}
