//
//  ItemCoordinator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/08.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

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
    
    override func start(with option: DeepLinkOption?) {
        if let id = option?.fetchItemDetailItemId() {
            showItemDetail(with: id)
        }
    }
    
    private func showItemList(executeFinishHandler: Bool = false) {
        
        let view = moduleFactory.generateItemListView()
        
        view.selectedItemHandler = { [weak self] itemId in
            self?.showItemDetail(with: itemId)
        }
        
        view.selectedUserHandler = { [weak self] userId in
            self?.runUserFlow(with: .userDetail(userId))
        }
        
        view.deinitHandler = { [weak self] in
            if executeFinishHandler {
                self?.finishFlow?()
            }
        }
        
        router.setRoot(view, hideBar: false)

    }
    
    private func showItemDetail(with itemId: String, executeFinishHandler: Bool = false) {
        let view = moduleFactory.generateItemDetailView(itemId: itemId)
        
        view.selectedUserHandler = { [weak self] id in
            self?.runUserFlow(with: .userDetail(id))
        }
        
        view.selectedLikeHandler = { [weak self] in
            if UserDefaults.StringType.value(key: .accessToken).isEmpty {
                self?.runLoginFlow()
                return false
            } else {
                return true
            }
        }
        
        view.selectedLikeCountHandler = { [weak self] in
            self?.runUserFlow(with: .likeUserList(itemId))
        }
        
        view.deinitHandler = { [weak self] in
            if executeFinishHandler {
                self?.finishFlow?()
            }
        }
        
        router.push(view, animated: true, completion: nil)
        
    }
    
}

extension ItemCoordinator {
    
    private func runLoginFlow() {
        
    }
    
    private func runUserFlow(with option: DeepLinkOption) {
        guard let navigationController = router.toPresent() as? UINavigationController else {
            return
        }
        let (presentable, coordinator) = coordinatorFactory.generateUserCoordinatorBox(navigationController: navigationController)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start(with: option)
        router.push(presentable, animated: true, completion: nil)
    }
    
}

