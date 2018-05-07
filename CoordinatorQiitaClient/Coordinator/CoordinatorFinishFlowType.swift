//
//  CoordinatorFinishFlowType.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol CoordinatorFinishFlowType: class {
    var finishFlow: (() -> Void)? { get set }
}
