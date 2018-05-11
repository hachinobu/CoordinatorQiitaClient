//
//  LikeUserAPI.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

class LikeUserAPI {
    
    class func fetchLikeUsersByItemIdWithRequestBuilder(itemId: String, page: Int, perPage: Int) -> RequestBuilder<[LikeUser]> {
        let path = "/api/v2/items/\(itemId)/likes"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values: ["page": page, "per_page": perPage])
        
        let requestBuilder: RequestBuilder<[LikeUser]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    class func fetchLikeStatusByItemIdWithRequestBuilder(itemId: String) -> RequestBuilder<Void> {
        let path = "/api/v2/items/\(itemId)/like"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    class func removeLikeByItemIdWithRequestBuilder(itemId: String) -> RequestBuilder<Void> {
        let path = "/api/v2/items/\(itemId)/like"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()
        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    class func putLikeByItemIdWithRequestBuilder(itemId: String) -> RequestBuilder<Void> {
        let path = "/api/v2/items/\(itemId)/like"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()
        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
}

extension LikeUserAPI {
    
    class func fetchLikeUsersByItemId(itemId: String, page: Int = 1, perPage: Int = 100, completion: @escaping ((_ data: [LikeUser]?, _ error: Error?) -> Void)) {
        fetchLikeUsersByItemIdWithRequestBuilder(itemId: itemId, page: page, perPage: perPage).execute { (response, error) in
            completion(response?.body, error)
        }
    }
    
    class func fetchLikeStatusByItemId(itemId: String, completion: @escaping ((_ error: Error?) -> Void)) {
        fetchLikeStatusByItemIdWithRequestBuilder(itemId: itemId).execute { (response, error) in
            completion(error)
        }
    }
    
    class func removeLikeByItemId(itemId: String, completion: @escaping ((_ error: Error?) -> Void)) {
        removeLikeByItemIdWithRequestBuilder(itemId: itemId).execute { (response, error) in
            completion(error)
        }
    }
    
    class func putLikeByItemId(itemId: String, completion: @escaping ((_ error: Error?) -> Void)) {
        putLikeByItemIdWithRequestBuilder(itemId: itemId).execute { (response, error) in
            completion(error)
        }
    }
    
}


