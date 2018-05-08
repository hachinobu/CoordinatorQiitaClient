//
//  ApplicationCoordinator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    
    private var finishLogin: Bool = false
    
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        if finishLogin {
            runServiceFlow()
        } else {
            runLoginFlow()
        }
    }
    
}

extension ApplicationCoordinator {
    
    private func runLoginFlow() {
        let coordinator = coordinatorFactory.generateAuthCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.finishLogin = true
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runServiceFlow() {
        let coordinator = coordinatorFactory.generateTabBarCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
}
