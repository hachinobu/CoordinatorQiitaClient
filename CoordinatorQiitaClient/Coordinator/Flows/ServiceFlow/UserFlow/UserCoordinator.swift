//
//  UserCoordinator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/10.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

final class UserCoordinator: BaseCoordinator, CoordinatorFinishFlowType {
    
    var finishFlow: (() -> Void)?
    
    private let moduleFactory: UserModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(moduleFactory: UserModuleFactory, coordinatorFactory: CoordinatorFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    override func start() {
        
    }
    
    override func start(with option: DeepLinkOption?) {
        guard let option = option else {
            start()
            return
        }
        
        if let itemId = option.fetchLikeUserListItemId() {
            showLikeUserList(with: itemId, executeFinishHandler: true)
        } else if let userId = option.fetchUserId() {
            showUserDetail(with: userId, executeFinishHandler: true)
        }
    }
    
    private func showLikeUserList(with itemId: String, executeFinishHandler: Bool = false) {
        let view = moduleFactory.generateLikeUserListView(with: itemId)
        
        view.deinitHandler = { [weak self] in
            if executeFinishHandler {
                self?.finishFlow?()
            }
        }
        
        view.selectedUserHandler = { [weak self] userId in
            self?.showUserDetail(with: userId)
        }
        
        router.push(view, animated: true, completion: nil)
    }
    
    private func showUserDetail(with userId: String, executeFinishHandler: Bool = false) {
        let view = moduleFactory.generateUserDetailView(with: userId)
        
        view.selectedFollowTagHandler = { [weak self] in
            print("selectedFollowTagHandler")
        }
        
        view.selectedFolloweeHandler = { [weak self] in
            self?.showFolloweeList(with: userId)
        }
        
        view.selectedFollowerHandler = { [weak self] in
            self?.showFollowerList(with: userId)
        }
        
        view.selectedItemHandler = { [weak self] itemId in
            self?.runItemFlow(with: .itemDetail(itemId))
        }
        
        view.deinitHandler = { [weak self] in
            if executeFinishHandler {
                self?.finishFlow?()
            }
        }
        
        router.push(view, animated: true, completion: nil)
        
    }
    
    private func showFolloweeList(with userId: String, executeFinishHandler: Bool = false) {
        let view = moduleFactory.generateFolloweeUserListView(with: userId)
        
        view.selectedUserHandler = { [weak self] userId in
            self?.showUserDetail(with: userId)
        }
        
        router.push(view, animated: true, completion: nil)
    }
    
    private func showFollowerList(with userId: String) {
        let view = moduleFactory.generateFollowerUserListView(with: userId)
        
        view.selectedUserHandler = { [weak self] userId in
            self?.showUserDetail(with: userId)
        }
                
        router.push(view, animated: true, completion: nil)
    }
    
}

extension UserCoordinator {
    
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
    
}


