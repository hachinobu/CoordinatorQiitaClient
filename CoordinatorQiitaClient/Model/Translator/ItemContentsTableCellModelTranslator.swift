//
//  ItemContentsTableCellModelTranslator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/09.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

struct ItemContentsTableCellModelTranslator: Translatable {
    
    func translate(input: Item) -> ItemContentsTableCellModel {
        let identifier = NSUUID().uuidString.hashValue
        let htmlBody = input.renderedBody
        return ItemContentsTableCellModel(identifier: identifier, htmlBody: htmlBody)
    }
    
}
