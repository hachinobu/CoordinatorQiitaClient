//
//  BaseCoordinator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

class BaseCoordinator: Coordinator, DependencyCoordinator {
    var childCoordinators: [Coordinator] = []
    
    func start() {
        fatalError("Required Override method")
    }
    
    func start(with option: DeepLinkOption?) {}
    
    func addDependency(_ coordinator: Coordinator) {
        if childCoordinators.contains(where: { $0 === coordinator }) {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator else {
            return
        }
        guard let index = childCoordinators.index(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.remove(at: index)
    }
    
}
