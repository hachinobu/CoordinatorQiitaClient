//
//  Tag.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/05.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

struct Tag: Codable {
    let followersCount: Int
    let iconUrl: String?
    let id: String
    let itemsCount: Int
}
