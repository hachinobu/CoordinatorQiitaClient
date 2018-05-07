//
//  AuthCoordinator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit
import SafariServices

final class AuthCoordinator: BaseCoordinator, CoordinatorFinishFlowType {
    
    var finishFlow: (() -> Void)?
    
    private var authSession: SFAuthenticationSession?
    
    private let moduleFactory: AuthModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(moduleFactory: AuthModuleFactory, coordinatorFactory: CoordinatorFactory, router: Router) {
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    override func start() {
        showLogin()
    }
    
    private func showLogin() {
        let loginView = moduleFactory.generateLoginView()
        
        loginView.onSkipAuth = { [weak self] in
            print("skip")
        }
        
        loginView.onLoginButtonTap = { [weak self] in
            print("login tap")
        }
        
        loginView.onCompleteAuth = { [weak self] token in
            self?.finishFlow?()
        }
        
        router.setRoot(loginView, hideBar: true)
    }
    
}

extension AuthCoordinator {
    
    private func authQiita() {
        
    }
    
}

