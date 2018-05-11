//
//  MypageCoordinator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/11.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

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
            self?.finishFlow?()
        }
        
        view.selectedItemHandler = { [weak self] itemId in
            
        }
        
        view.selectedFolloweeHandler = { [weak self] in
            
        }
        
        view.selectedFollowerHandler = { [weak self] in
            
        }
        
        view.selectedFollowTagHandler = { [weak self] in
            
        }
        
        router.setRoot(view, hideBar: false)
        
    }
    
    
}
