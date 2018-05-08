//
//  TabModuleFactory.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/08.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol TabModuleFactory {
    func generateTabView(with selected: TabbarController.SelectTab) -> TabViewOutput
}
