//
//  ApplicationCoordinator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    
    private var finishLoagin: Bool = false
    
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        if finishLoagin {
            
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
            self?.finishLoagin = true
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
}
