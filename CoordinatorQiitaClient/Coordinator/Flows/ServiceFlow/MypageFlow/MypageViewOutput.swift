//
//  MypageViewOutput.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/11.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol MypageViewOutput: BaseView {
    var selectedFollowTagHandler: ((String) -> Void)? { get set }
    var selectedFolloweeHandler: ((String) -> Void)? { get set }
    var selectedFollowerHandler: ((String) -> Void)? { get set }
    var selectedItemHandler: ((String) -> Void)? { get set }
    var selectedLogoutHandler: (() -> Void)? { get set }
}
