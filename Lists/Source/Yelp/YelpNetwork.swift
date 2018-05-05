//
//  YelpNetwork.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire
import RxAlamofire
import RxSwift

struct YelpNetwork: Network {
    
    let baseUrl = "https://api.yelp.com/v3/"
    
    func requestJson(_ request: APIRequest) -> Observable<Json> {
        return RxAlamofire
            .json(request.method.toAlamofireMethod,
                  baseUrl + request.urlString,
                  parameters: nil,
                  encoding: URLEncoding.default,
                  headers: ["Authorization": "Bearer" + " " + YelpApiKey.app])
            .map { json -> Json in
                if let json = json as? Json {
                    return json
                }
                print("Error receiving json response: \(request.method) \(request.urlString)")
                return [:]
        }
    }
}
