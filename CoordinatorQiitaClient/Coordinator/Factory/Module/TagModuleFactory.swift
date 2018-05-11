//
//  TagModuleFactory.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/11.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol TagModuleFactory {
    func generateAllTagListView() -> TagListViewOutput
    func generateTagItemListView(with tagId: String) -> ItemListViewOutput
}
