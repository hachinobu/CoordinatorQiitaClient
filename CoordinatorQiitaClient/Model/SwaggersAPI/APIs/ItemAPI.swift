//
//  ItemAPI.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/05.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation
import Alamofire

class ItemAPI {
    
    class func fetchItemsByPageWithRequestBuilder(page: Int, perPage: Int) -> RequestBuilder<[Item]> {
        let path = "/api/v2/items"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String: Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values: ["page": page, "per_page": perPage])
        
        let requestBuilder: RequestBuilder<[Item]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    class func fetchItemByItemIdWithRequestBuilder(id: String) -> RequestBuilder<Item> {
        var path = "/api/v2/items/{itemId}"
        path = path.replacingOccurrences(of: "{itemId}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        let requestBuilder: RequestBuilder<Item>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    class func fetchItemsByUserIdWithRequestBuilder(id: String, page: Int, perPage: Int) -> RequestBuilder<[Item]> {
        var path = "/api/v2/users/{userId}/items"
        path = path.replacingOccurrences(of: "{userId}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values: ["page": page, "per_page": perPage])
        let requestBuilder: RequestBuilder<[Item]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    class func fetchItemsByTagIdWithRequestBuilder(id: String, page: Int, perPage: Int) -> RequestBuilder<[Item]> {
        var path = "/api/v2/tags/{tagId}/items"
        path = path.replacingOccurrences(of: "{tagId}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values: ["page": page, "per_page": perPage])
        let requestBuilder: RequestBuilder<[Item]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    class func fetchAuthUserItemsWithRequestBuilder(page: Int, perPage: Int) -> RequestBuilder<[Item]> {
        let path = "/api/v2/authenticated_user/items"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values: ["page": page, "per_page": perPage])
        let requestBuilder: RequestBuilder<[Item]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
}

//execute
extension ItemAPI {
    
    class func fetchItemsByPageInfo(page: Int = 1, perPage: Int = 50, completion: @escaping ((_ data: [Item]?, _ error: Error?) -> Void)) {
        fetchItemsByPageWithRequestBuilder(page: page, perPage: perPage).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }
    
    class func fetchItemByItemId(id: String, completion: @escaping ((_ data: Item?, _ error: Error?) -> Void)) {
        fetchItemByItemIdWithRequestBuilder(id: id).execute { (response, error) in
            completion(response?.body, error)
        }
    }
    
    class func fetchItemsByUserId(id: String, page: Int = 1, perPage: Int = 50, completion: @escaping ((_ data: [Item]?, _ error: Error?) -> Void)) {
        fetchItemsByUserIdWithRequestBuilder(id: id, page: page, perPage: perPage).execute { (response, error) in
            completion(response?.body, error)
        }
    }
    
    class func fetchItemsByTagId(id: String, page: Int = 1, perPage: Int = 50, completion: @escaping ((_ data: [Item]?, _ error: Error?) -> Void)) {
        fetchItemsByTagIdWithRequestBuilder(id: id, page: page, perPage: perPage).execute { (response, error) in
            completion(response?.body, error)
        }
    }
    
    class func fetchAuthUserItems(page: Int = 1, perPage: Int = 50, completion: @escaping ((_ data: [Item]?, _ error: Error?) -> Void)) {
        fetchAuthUserItemsWithRequestBuilder(page: page, perPage: perPage).execute { (response, error) in
            completion(response?.body, error)
        }
    }
    
}

