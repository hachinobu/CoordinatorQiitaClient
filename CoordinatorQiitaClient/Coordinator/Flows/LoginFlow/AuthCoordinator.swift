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
            self?.finishFlow?()
        }
        
        loginView.onLoginButtonTap = { [weak self] in
            self?.authQiita()
        }
        
        loginView.onCompleteAuth = { [weak self] token in
            UserDefaults.StringType.set(value: token, key: .accessToken)
            self?.finishFlow?()
        }
        
        router.setRoot(loginView, hideBar: true)
    }
    
}

extension AuthCoordinator {
    
    private func authQiita() {
        let url: URL = URL(string:"http://qiita.com/api/v2/oauth/authorize?client_id=\(Config.AuthInfo.clientId)&scope=read_qiita+write_qiita&state=\(Config.AuthInfo.accessTokenState)")!
        print(url.absoluteString)
        authSession = SFAuthenticationSession(url: url, callbackURLScheme: Config.AuthInfo.redirectUrlScheme) { [weak self] (url, error) in
            if let url = url, let code = self?.fetchAuthoriedCode(url: url) {
                let body = Auth.PostBody(clientId: Config.AuthInfo.clientId, clientSecret: Config.AuthInfo.clientSecret, code: code)
                NotificationCenter.default.post(name: NSNotification.Name.Auth.CompleteAuthCode, object: nil, userInfo: [Config.Key.authPostBody: body])
            }
        }
        authSession?.start()
    }
    
    private func fetchAuthoriedCode(url: URL) -> String? {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        guard let scheme = urlComponents?.scheme, scheme.hasPrefix(Config.AuthInfo.redirectUrlScheme),
            let queryItems = urlComponents?.queryItems else { return nil }
        
        let query = queryItems.reduce(into: [String: String]()) { (result, item) in
            let value = item.value ?? ""
            result[item.name] = value
        }
        
        guard let code = query["code"], let state = query["state"],
            state == Config.AuthInfo.accessTokenState else { fatalError("") }
        
        return code
    }
    
}

