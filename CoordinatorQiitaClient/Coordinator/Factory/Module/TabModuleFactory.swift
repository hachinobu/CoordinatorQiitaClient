//
//  TabModuleFactory.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/08.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

protocol TabModuleFactory {
    func generateTabView(with selected: TabbarController.SelectTab, itemTabHandler: @escaping ((UINavigationController) -> Void), tagTabHandler: @escaping ((UINavigationController) -> Void), mypageTabHandler: @escaping ((UINavigationController) -> Void)) -> TabViewOutput
}
