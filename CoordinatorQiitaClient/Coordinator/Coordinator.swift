//
//  Coordinator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    func start()
    func start(with option: DeepLinkOption?)
}

protocol DependencyCoordinator: class {
    var childCoordinators: [Coordinator] { get }
    
    func addDependency(_ coordinator: Coordinator)
    func removeDependency(_ coordinator: Coordinator?)
}
