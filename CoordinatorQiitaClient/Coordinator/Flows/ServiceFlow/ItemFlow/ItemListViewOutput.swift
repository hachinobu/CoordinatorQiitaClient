//
//  ItemListViewOutput.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/08.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol ItemListViewOutput: BaseView {
    var selectedItemHandler: ((String) -> Void)? { get set }
    var selectedUserHandler: ((String) -> Void)? { get set }
    var deinitViewHandler: (() -> Void)? { get set }
}
