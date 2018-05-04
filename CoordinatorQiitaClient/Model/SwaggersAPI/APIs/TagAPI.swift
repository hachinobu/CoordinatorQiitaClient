//
//  TagAPI.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/06.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

class TagAPI {
    
    enum TagSort: String {
        case count
        case name
    }
    
    class func fetchAllTagsWithRequestBuilder(page: Int, perPage: Int, sort: TagSort) -> RequestBuilder<[Tag]> {
        let path = "/api/v2/tags"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values: ["page": page, "per_page": perPage, "sort": sort.rawValue])
        
        let requestBuilder: RequestBuilder<[Tag]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    class func fetchFollowTagsByUserIdWithRequestBuilder(userId: String, page: Int, perPage: Int) -> RequestBuilder<[Tag]> {
        let path = "/api/v2/users/\(userId)/following_tags"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values: ["page": page, "per_page": perPage])
        
        let requestBuilder: RequestBuilder<[Tag]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    class func fetchFollowingStausTagByIdWithRequestBuilder(tagId: String) -> RequestBuilder<Tag> {
        let path = "/api/v2/tags/\(tagId)/following"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        
        let requestBuilder: RequestBuilder<Tag>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    class func removeFollowTagByIdWithRequestBuilder(tagId: String) -> RequestBuilder<Void> {
        let path = "/api/v2/tags/\(tagId)/following"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()
        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    class func followTagByIdWithRequestBuilder(tagId: String) -> RequestBuilder<Void> {
        let path = "/api/v2/tags/\(tagId)/following"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()
        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
}

extension TagAPI {
    
    class func fetchAllTags(id: String, page: Int = 1, perPage: Int = 20, sort: TagSort = .count, completion: @escaping ((_ data: [Tag]?, _ error: Error?) -> Void)) {
        fetchAllTagsWithRequestBuilder(page: page, perPage: perPage, sort: sort).execute { (response, error) in
            completion(response?.body, error)
        }
    }
    
    class func fetchFollowTags(userId: String, page: Int = 1, perPage: Int = 20, completion: @escaping ((_ data: [Tag]?, _ error: Error?) -> Void)) {
        fetchFollowTagsByUserIdWithRequestBuilder(userId: userId, page: page, perPage: perPage).execute { (response, error) in
            completion(response?.body, error)
        }
    }
    
    class func fetchFollowingStatusTag(tagId: String, completion: @escaping ((_ data: Tag?, _ error: Error?) -> Void)) {
        fetchFollowingStausTagByIdWithRequestBuilder(tagId: tagId).execute { (response, error) in
            completion(response?.body, error)
        }
    }
    
    class func followTag(tagId: String, completion: @escaping ((_ error: Error?) -> Void)) {
        followTagByIdWithRequestBuilder(tagId: tagId).execute { (response, error) in
            completion(error)
        }
    }
    
    class func removeFollowTag(tagId: String, completion: @escaping ((_ error: Error?) -> Void)) {
        removeFollowTagByIdWithRequestBuilder(tagId: tagId).execute { (response, error) in
            completion(error)
        }
    }
    
}
