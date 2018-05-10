//
//  UserAPI.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/05.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

class UserAPI {
    
    class func fetchUserDetailByUserIdWithRequestBuilder(userId: String) -> RequestBuilder<User> {
        var path = "/api/v2/users/{userId}"
        path = path.replacingOccurrences(of: "{userId}", with: "\(userId)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        
        let requestBuilder: RequestBuilder<User>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    class func fetchFolloweesByUserIdWithRequestBuilder(userId: String, page: Int, perPage: Int) -> RequestBuilder<[User]> {
        var path = "/api/v2/users/{userId}/followees"
        path = path.replacingOccurrences(of: "{userId}", with: "\(userId)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values: ["page": page, "per_page": perPage])
        
        let requestBuilder: RequestBuilder<[User]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    class func fetchFollowersByUserIdWithRequestBuilder(userId: String, page: Int, perPage: Int) -> RequestBuilder<[User]> {
        var path = "/api/v2/users/{userId}/followers"
        path = path.replacingOccurrences(of: "{userId}", with: "\(userId)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values: ["page": page, "per_page": perPage])
        
        let requestBuilder: RequestBuilder<[User]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
}

extension UserAPI {
    
    class func fetchUserDetailByUserId(id: String, completion: @escaping ((_ data: User?, _ error: Error?) -> Void)) {
        fetchUserDetailByUserIdWithRequestBuilder(userId: id).execute { (response, error) in
            completion(response?.body, error)
        }
    }
    
    class func fetchFolloweesByUserId(id: String, page: Int = 1, perPage: Int = 100, completion: @escaping ((_ data: [User]?, _ error: Error?) -> Void)) {
        fetchFolloweesByUserIdWithRequestBuilder(userId: id, page: page, perPage: perPage).execute { (response, error) in
            completion(response?.body, error)
        }
    }
    
    class func fetchFollowersByUserId(id: String, page: Int = 1, perPage: Int = 100, completion: @escaping ((_ data: [User]?, _ error: Error?) -> Void)) {
        fetchFollowersByUserIdWithRequestBuilder(userId: id, page: page, perPage: perPage).execute { (response, error) in
            completion(response?.body, error)
        }
    }
    
}

