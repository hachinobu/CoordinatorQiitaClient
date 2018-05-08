//
//  CoordinatorFactory.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

protocol CoordinatorFactory {
    func generateAuthCoordinator(router: Router) -> Coordinator & CoordinatorFinishFlowType
    func generateTabBarCoordinator(router: Router) -> Coordinator & CoordinatorFinishFlowType
}
