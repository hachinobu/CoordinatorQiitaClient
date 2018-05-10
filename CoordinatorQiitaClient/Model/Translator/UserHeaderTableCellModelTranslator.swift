//
//  UserHeaderTableCellModelTranslator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/10.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

struct UserHeaderTableCellModelTranslator: Translatable {
    
    private var paragraphStyle: NSParagraphStyle {
        let lineHeight: CGFloat = 22.0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        return paragraphStyle
    }
    
    func translate(input: User) -> UserHeaderTableCellModel {
        
        let identifier = NSUUID().uuidString.hashValue
        let profileURL = URL(string: input.profileImageUrl)
        let userId = input.id
        let userName = input.name
        let company = input.organization
        let itemCount = "投稿数: " + input.itemsCount.description
        let followeeCount = "フォローしている数: " + input.followeesCount.description
        let followerCount = "フォローされてる数: " + input.followersCount.description
        
        let description = input.description ?? ""
        let attributedDescription = NSMutableAttributedString(string: description)
        attributedDescription.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedDescription.length))
        
        return UserHeaderTableCellModel(identifier: identifier, profileURL: profileURL, userId: userId, userName: userName, company: company, itemCount: itemCount, followeeUserCount: followeeCount, followerUserCount: followerCount, description: attributedDescription)
        
    }
    
}
