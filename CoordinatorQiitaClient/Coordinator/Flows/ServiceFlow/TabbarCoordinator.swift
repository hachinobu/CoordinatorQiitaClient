//
//  TabbarCoordinator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/08.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

final class TabbarCoordinator: BaseCoordinator, CoordinatorFinishFlowType {
    
    var finishFlow: (() -> Void)?
    
    private let moduleFactory: TabModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    private var currentTab: TabbarController.SelectTab = .item
    
    init(moduleFactory: TabModuleFactory, coordinatorFactory: CoordinatorFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    override func start() {
        showTabView()
    }
    
    private func showTabView() {
        let view = moduleFactory.generateTabView(with: currentTab)
        
        view.selectedItemTabHandler = { [weak self] navigationController in
            self?.currentTab = .item
            self?.runItemTabFlow(with: navigationController)
        }
        
        view.selectedTagTabHandler = { [weak self] navigationController in
            self?.currentTab = .tag
            self?.runTagTabFlow(with: navigationController)
        }
        
        view.selectedMypageTabHandler = { [weak self] navigationController in
            self?.currentTab = .mypage
            if UserDefaults.StringType.value(key: .accessToken).isEmpty {
                self?.runAuthFlow(with: navigationController)
            } else {
                self?.runMypageTabFlow(with: navigationController)
            }
        }
        
        router.setRoot(view, hideBar: true)
    }
    
}

extension TabbarCoordinator {
    
    private func runItemTabFlow(with navigationController: UINavigationController) {
        guard navigationController.viewControllers.isEmpty else {
            return
        }
        let coordinator = coordinatorFactory.generateItemCoordinator(navigationController: navigationController)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            coordinator?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runTagTabFlow(with navigationController: UINavigationController) {
        
    }
    
    private func runMypageTabFlow(with navigationController: UINavigationController) {
        
    }
    
    private func runAuthFlow(with navigationController: UINavigationController) {
        
    }
    
}


