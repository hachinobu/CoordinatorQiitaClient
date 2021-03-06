//
//  AuthViewController.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController, LoginViewOutput {

    var onCompleteAuth: ((String) -> Void)?
    var onSkipAuth: (() -> Void)?
    var onLoginButtonTap: (() -> Void)?
    var deinitHandler: (() -> Void)?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    lazy var loginView: LoginView = {
        let login = LoginView.instantiate()
        view.addSubview(login)
        login.translatesAutoresizingMaskIntoConstraints = false
        login.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        login.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        login.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        login.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return login
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        registerNotification()
    }
    
    private func setupViews() {
        loginView.loginButton.addTarget(self, action: .tappedLoginButton, for: .touchUpInside)
        loginView.skipAuthButton.addTarget(self, action: .tappedSkipAuthButton, for: .touchUpInside)
    }
    
    private func registerNotification() {
        let center = NotificationCenter.default
        center.addObserver(forName: Notification.Name.Auth.CompleteAuthCode, object: nil, queue: nil) { [weak self] (notification) in
            guard let postBody = notification.userInfo?[Config.Key.authPostBody] as? Auth.PostBody else {
                return
            }
            self?.fetchQiitaAccessToken(with: postBody)
        }
    }
    
    private func fetchQiitaAccessToken(with body: Auth.PostBody) {
        AuthAPI.accessTokenRequestBuilder(body: body).execute { [weak self] (response, error) in
            guard let accessToken = response?.body?.token else {
                return
            }
            self?.onCompleteAuth?(accessToken)
        }
    }
    
}

private extension Selector {
    static let tappedLoginButton = #selector(AuthViewController.tappedLoginButton(_:))
    static let tappedSkipAuthButton = #selector(AuthViewController.tappedSkipAuthButton(_:))
}

extension AuthViewController {
    
    @objc func tappedLoginButton(_ sender: Any) {
        onLoginButtonTap?()
    }
    
    @objc func tappedSkipAuthButton(_ sender: Any) {
        onSkipAuth?()
    }
    
}

