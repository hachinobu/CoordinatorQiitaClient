//
//  User.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/04.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

// Copy by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

struct User: Codable {
    
    var description: String?
    var facebookId: String?
    var followeesCount: Int
    var followersCount: Int
    var githubLoginName: String?
    var id: String
    var itemsCount: Int
    var linkedinId: String?
    var location: String?
    var name: String?
    var organization: String?
    var permanentId: Int
    var profileImageUrl: String
    var twitterScreenName: String?
    var websiteUrl: String?
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: String.self)
//
//        try container.encodeIfPresent(description, forKey: "description")
//        try container.encodeIfPresent(facebookId, forKey: "facebook_id")
//        try container.encodeIfPresent(followeesCount, forKey: "followees_count")
//        try container.encodeIfPresent(followersCount, forKey: "followers_count")
//        try container.encodeIfPresent(githubLoginName, forKey: "github_login_name")
//        try container.encodeIfPresent(id, forKey: "id")
//        try container.encodeIfPresent(itemsCount, forKey: "items_count")
//        try container.encodeIfPresent(linkedinId, forKey: "linkedin_id")
//        try container.encodeIfPresent(location, forKey: "location")
//        try container.encodeIfPresent(name, forKey: "name")
//        try container.encodeIfPresent(organization, forKey: "organization")
//        try container.encodeIfPresent(permanentId, forKey: "permanent_id")
//        try container.encodeIfPresent(profileImageUrlString, forKey: "profile_image_url")
//        try container.encodeIfPresent(twitterScreenName, forKey: "twitter_screen_name")
//        try container.encodeIfPresent(websiteUrl, forKey: "website_url")
//
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: String.self)
//
//        description = try container.decodeIfPresent(String.self, forKey: "description")
//        facebookId = try container.decodeIfPresent(String.self, forKey: "facebook_id")
//        followeesCount = try container.decodeIfPresent(Int.self, forKey: "followees_count")
//        followersCount = try container.decodeIfPresent(Int.self, forKey: "followers_count")
//        githubLoginName = try container.decodeIfPresent(String.self, forKey: "github_login_name")
//        id = try container.decodeIfPresent(String.self, forKey: "id")
//        itemsCount = try container.decodeIfPresent(Int.self, forKey: "items_count")
//        linkedinId = try container.decodeIfPresent(String.self, forKey: "linkedin_id")
//        location = try container.decodeIfPresent(String.self, forKey: "location")
//        name = try container.decodeIfPresent(String.self, forKey: "name")
//        organization = try container.decodeIfPresent(String.self, forKey: "organization")
//        permanentId = try container.decodeIfPresent(Int.self, forKey: "permanent_id")
//        profileImageUrlString = try container.decodeIfPresent(String.self, forKey: "profile_image_url")
//        twitterScreenName = try container.decodeIfPresent(String.self, forKey: "twitter_screen_name")
//        websiteUrl = try container.decodeIfPresent(String.self, forKey: "website_url")
//
//    }
    
}
