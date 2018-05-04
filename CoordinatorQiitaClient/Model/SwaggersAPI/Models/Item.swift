//
//  Item.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/05.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

struct Item: Codable {
    let renderedBody: String
    let body: String
    let coediting: Bool
    let createdAt: String
    let id: String
    let likesCount: Int
    let tags: [ItemTag]
    let title: String
    let updatedAt: String
    let url: String
    let user: User
    
    struct ItemTag: Codable {
        let name: String
        let versions: [String]
    }
}
