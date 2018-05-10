//
//  ItemHeaderTableCellModelTranslator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/09.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

struct ItemHeaderTableCellModelTranslator: Translatable {
    
    private var paragraphStyle: NSParagraphStyle {
        let lineHeight: CGFloat = 22.0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        return paragraphStyle
    }
    
    func translate(input: (item: Item, likeStatus: Bool)) -> ItemHeaderTableCellModel {
        let identifier = NSUUID().uuidString.hashValue
        
        let itemId = input.item.id
        let userId = input.item.user.id
        let attributedTitle = NSMutableAttributedString(string: input.item.title)
        attributedTitle.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedTitle.length))
        let title = attributedTitle
        let tag = input.item.tags.map { $0.name }.joined(separator: ", ")
        let profileURL = URL(string: input.item.user.profileImageUrl)
        let userName = input.item.user.id
        let likeCount = "いいね数:" + input.item.likesCount.description
        let hasLike = input.likeStatus
        
        return ItemHeaderTableCellModel(identifier: identifier, itemId: itemId,
                                        userId: userId, title: title,
                                        tag: tag, profileURL: profileURL,
                                        userName: userName, likeCount: likeCount,
                                        hasLike: hasLike)
    }
    
}
