//
//  AuthAPI.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/05.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation
import Alamofire

class AuthAPI {
    
    class func accessTokenRequestBuilder(body: Auth.PostBody) -> RequestBuilder<Auth.AccessTokenInfo> {
        let path = "/api/v2/access_tokens"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: body)
        
        let url = NSURLComponents(string: URLString)
        let requestBuilder: RequestBuilder<Auth.AccessTokenInfo>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()
        
        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    
}

//execute
extension AuthAPI {
    
    class func postAccessToken(body: Auth.PostBody, completion: @escaping ((_ data: Auth.AccessTokenInfo?, _ error: Error?) -> Void)) {
        accessTokenRequestBuilder(body: body).execute { (response, error) in
            completion(response?.body, error)
        }
    }
    
}
