//
//  ModuleFactory.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

final class ModuleFactory {}

extension ModuleFactory: AuthModuleFactory {
    func generateLoginView() -> LoginViewOutput {
        let view = AuthViewController()
        return view
    }
}

