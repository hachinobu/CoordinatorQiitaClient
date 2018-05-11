//
//  TagCoordinator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/11.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

import UIKit

final class TagCoordinator: BaseCoordinator, CoordinatorFinishFlowType {
    
    var finishFlow: (() -> Void)?
    
    private let moduleFactory: TagModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(moduleFactory: TagModuleFactory, coordinatorFactory: CoordinatorFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    override func start() {
        showAllTagList()
    }
    
    override func start(with option: DeepLinkOption?) {
        if let tagId = option?.fetchTagItemListTagId() {
            showTagItemList(with: tagId, executeFinishHandler: true)
        } else {
            start()
        }
    }
    
    private func showAllTagList() {
        
        let view = moduleFactory.generateAllTagListView()
        
        view.selectedTagHandler = { [weak self] tagId in
            self?.showTagItemList(with: tagId)
        }
        
        router.setRoot(view, hideBar: false)
        
    }
    
    private func showTagItemList(with tagId: String, executeFinishHandler: Bool = false) {
        let view = moduleFactory.generateTagItemListView(with: tagId)
        
        view.deinitHandler = { [weak self] in
            if executeFinishHandler {
                self?.finishFlow?()
            }
        }
        
        view.selectedItemHandler = { [weak self] itemId in
            self?.runItemFlow(with: .itemDetail(itemId))
        }
        
        view.selectedUserHandler = { [weak self] userId in
            self?.runUserFlow(with: .itemDetail(userId))
        }
        
        router.push(view, animated: true, completion: nil)
        
    }
        
}

extension TagCoordinator {
    
    private func runItemFlow(with option: DeepLinkOption) {
        guard let navigationController = router.toPresent() as? UINavigationController else {
            return
        }
        let (presentable, coordinator) = coordinatorFactory.generateItemCoordinatorBox(navigationController: navigationController)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start(with: option)
        router.push(presentable, animated: true, completion: nil)
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

