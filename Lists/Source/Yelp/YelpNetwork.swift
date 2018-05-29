//
//  YelpNetwork.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire

struct YelpNetwork: Network {
    
    let sessionManager: SessionManager
    let baseUrl = "https://api.yelp.com/v3/"
    
    func requestJson(_ request: APIRequest, completion: @escaping (Result<Json>) -> Void) {
        sessionManager
            .request(request,
                     method: request.method,
                     parameters: nil,
                     encoding: URLEncoding.default,
                     headers: ["Authorization": "Bearer" + " " + YelpApiKey.app])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                completion(response.result.mapOptional { $0 as? Json })
            }
    }
}
