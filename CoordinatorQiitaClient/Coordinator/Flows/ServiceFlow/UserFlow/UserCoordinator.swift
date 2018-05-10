//
//  UserCoordinator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/10.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

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
            showLikeUserList(with: itemId)
        }
    }
    
    private func showLikeUserList(with itemId: String) {
        let view = moduleFactory.generateLikeUserListView(with: itemId)
        
        view.deinitHandler = { [weak self] in
            self?.finishFlow?()
        }
        
        view.selectedUserHandler = { [weak self] userId in
            
        }
        
        router.push(view, animated: true, completion: nil)
    }
    
}
