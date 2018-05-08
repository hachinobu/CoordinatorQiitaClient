//
//  ItemModuleFactory.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/08.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol ItemModuleFactory {
    func generateItemListView() -> ItemListViewOutput
}
