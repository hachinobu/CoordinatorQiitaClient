//
//  TagListTableCellModelTranslator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/11.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

struct TagListTableCellModelTranslator: Translatable {
    
    func translate(input: Tag) -> TagListTableCellModel {
        let identifier = NSUUID().uuidString.hashValue
        let tagId = input.id
        let tagName = input.id
        var tagImageURL: URL? = nil
        if let iconURL = input.iconUrl {
            tagImageURL = URL(string: iconURL)
        }
        let tagCountInfo: String = "投稿数: \(input.itemsCount.description)  フォロワー数: \(input.followersCount.description)"
        return TagListTableCellModel(identifier: identifier, tagId: tagId, tagName: tagName, tagImageURL: tagImageURL, tagCountInfo: tagCountInfo)
    }
    
}
