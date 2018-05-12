//
//  MypageCoordinator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/11.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

final class MypageCoordinator: BaseCoordinator, CoordinatorFinishFlowType {
    
    var finishFlow: (() -> Void)?
    
    private let moduleFactory: MypageModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(moduleFactory: MypageModuleFactory, coordinatorFactory: CoordinatorFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    override func start() {
        showMypageView()
    }
    
    override func start(with option: DeepLinkOption?) {
        
    }
    
    private func showMypageView() {
        let view = moduleFactory.generateMypageView()
        
        view.selectedLogoutHandler = { [weak self] in
            UserDefaults.StringType.remove(key: .accessToken)
            self?.finishFlow?()
        }
        
        view.selectedItemHandler = { [weak self] itemId in
            self?.runItemFlow(with: .itemDetail(itemId))
        }
        
        view.selectedFolloweeHandler = { [weak self] userId in
            self?.runUserFlow(with: .followeeUserList(userId))
        }
        
        view.selectedFollowerHandler = { [weak self] userId in
            self?.runUserFlow(with: .followerUserList(userId))
        }
        
        view.selectedFollowTagHandler = { [weak self] userId in
            self?.runUserFlow(with: .userFollowTag(userId))
        }
        
        router.setRoot(view, hideBar: false)
        
    }
    
    
}

extension MypageCoordinator {
    
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

