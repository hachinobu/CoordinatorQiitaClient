//
//  ItemListTableCellModelTranslator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/08.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

struct ItemListTableCellModelTranslator: Translatable {
    
    private var paragraphStyle: NSParagraphStyle {
        let lineHeight: CGFloat = 22.0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        return paragraphStyle
    }
    
    func translate(input: Item) -> ItemListTableCellModel {
        
        let identifier = NSUUID().uuidString.hashValue
        let itemId = input.id
        let userId = input.user.id
        let profileURL = URL(string: input.user.profileImageUrl)
        let userName = input.user.id
        let likeCount = input.likesCount.description + "いいね"
        let attributedTitle = NSMutableAttributedString(string: input.title)
        attributedTitle.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedTitle.length))
        let tag = input.tags.map { $0.name }.joined(separator: ", ")
        
        return ItemListTableCellModel(identifier: identifier,
                                      itemId: itemId,
                                      userId: userId,
                                      profileURL: profileURL,
                                      userName: userName,
                                      likeCount: likeCount,
                                      title: attributedTitle,
                                      tag: tag)
    }
    
}
