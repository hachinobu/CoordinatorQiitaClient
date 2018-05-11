//
//  UserDetailViewOutput.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/10.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol UserDetailViewOutput: BaseView {
    var selectedFollowTagHandler: (() -> Void)? { get set }
    var selectedFolloweeHandler: (() -> Void)? { get set }
    var selectedFollowerHandler: (() -> Void)? { get set }
    var selectedItemHandler: ((String) -> Void)? { get set }
}
