//
//  CoordinatorFactoryImpl.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

final class CoordinatorFactoryImpl: CoordinatorFactory {
    
    func generateAuthCoordinator(router: Router) -> Coordinator & CoordinatorFinishFlowType {
        let coordinator = AuthCoordinator(moduleFactory: ModuleFactory(),
                                          coordinatorFactory: CoordinatorFactoryImpl(),
                                          router: router)
        return coordinator
    }
    
}
