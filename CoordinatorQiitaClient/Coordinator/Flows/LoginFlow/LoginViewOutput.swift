//
//  LoginViewOutput.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol LoginViewOutput: BaseView {
    var onCompleteAuth: ((String) -> Void)? { get set }
    var onSkipAuth: (() -> Void)? { get set }
    var onLoginButtonTap: (() -> Void)? { get set }
}
