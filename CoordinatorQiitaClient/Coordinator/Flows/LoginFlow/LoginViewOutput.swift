//
//  LoginViewOutput.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol LoginViewOutput: BaseView {
    var onCompleteAuth: (() -> Void)? { get }
    var onSkipAuth: (() -> Void)? { get }
    var onLoginButtonTap: (() -> Void)? { get }
}
