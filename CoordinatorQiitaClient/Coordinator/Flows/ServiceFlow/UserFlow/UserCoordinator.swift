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
        } else if let userId = option.fetchUserId() {
            showUserDetail(with: userId)
        }
    }
    
    private func showLikeUserList(with itemId: String) {
        let view = moduleFactory.generateLikeUserListView(with: itemId)
        
        view.deinitHandler = { [weak self] in
            self?.finishFlow?()
        }
        
        view.selectedUserHandler = { [weak self] userId in
            self?.showUserDetail(with: userId)
        }
        
        router.push(view, animated: true, completion: nil)
    }
    
    private func showUserDetail(with userId: String) {
        let view = moduleFactory.generateUserDetailView(with: userId)
        
        view.selectedFollowTagHandler = { [weak self] in
            print("selectedFollowTagHandler")
        }
        
        view.selectedFolloweeHandler = { [weak self] in
            print("selectedFolloweeHandler")
        }
        
        view.selectedFollowerHandler = { [weak self] in
            print("selectedFollowerHandler")
        }
        
        view.selectedItemHandler = { [weak self] itemId in
            print("selectedFollowerHandler")
        }
        
        view.deinitHandler = { [weak self] in
            self?.finishFlow?()
        }
        
        router.push(view, animated: true, completion: nil)
        
    }
    
}
