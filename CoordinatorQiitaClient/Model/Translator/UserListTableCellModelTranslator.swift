//
//  UserListTableCellModelTranslator.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/10.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

struct UserListTableCellModelTranslator: Translatable {
    
    func translate(input: User) -> UserListTableCellModel {
        let identifier = NSUUID().uuidString.hashValue
        let userId = input.id
        let userName = input.id
        let profileURL = URL(string: input.profileImageUrl)
        return UserListTableCellModel(identifier: identifier, userId: userId, userName: userName, profileURL: profileURL)
    }
    
}
