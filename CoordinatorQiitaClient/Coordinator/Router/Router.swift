//
//  Router.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol Router: Presentable {
    func setRoot(_ presentable: Presentable?, hideBar: Bool)
    func popToRoot(animated: Bool)
    func present(_ presentable: Presentable?, animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func push(_ presentable: Presentable?, animated: Bool, completion: (() -> Void)?)
    func pop(animated: Bool)
}

