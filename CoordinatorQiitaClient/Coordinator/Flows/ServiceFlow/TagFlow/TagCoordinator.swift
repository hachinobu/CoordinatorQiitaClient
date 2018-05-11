//
//  TagCoordinator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/11.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

import UIKit

final class TagCoordinator: BaseCoordinator, CoordinatorFinishFlowType {
    
    var finishFlow: (() -> Void)?
    
    private let moduleFactory: TagModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(moduleFactory: TagModuleFactory, coordinatorFactory: CoordinatorFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    override func start() {
        showAllTagList()
    }
    
    override func start(with option: DeepLinkOption?) {
        if let id = option?.fetchFollowTagUserId() {
            showFollowTagList(with: id, executeFinishHandler: true)
        } else {
            start()
        }
    }
    
    private func showAllTagList() {
        
        let view = moduleFactory.generateAllTagListView()
        
        view.selectedTagHandler = { [weak self] tagId in
            
        }
        
        router.setRoot(view, hideBar: false)
        
    }
    
    private func showFollowTagList(with userId: String, executeFinishHandler: Bool = false) {
        let view = moduleFactory.generateFollowTagListView(with: userId)
        
        view.selectedTagHandler = { [weak self] tagId in
            
        }
        
        view.deinitHandler = { [weak self] in
            if executeFinishHandler {
                self?.finishFlow?()
            }
        }
        
        router.push(view, animated: true, completion: nil)
    }
        
}
