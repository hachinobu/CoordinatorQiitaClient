//
//  LikeUserListViewOutput.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/10.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol UserListViewOutput: BaseView {
    var selectedUserHandler: ((String) -> Void)? { get set }
}
