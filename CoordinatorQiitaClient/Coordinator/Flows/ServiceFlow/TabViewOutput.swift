//
//  TabViewOutput.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/08.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

protocol TabViewOutput: BaseView {
    var selectedItemTabHandler: ((UINavigationController) -> Void)? { get set }
    var selectedTagTabHandler: ((UINavigationController) -> Void)? { get set }
    var selectedMypageTabHandler: ((UINavigationController) -> Void)? { get set }
}
