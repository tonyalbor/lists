//
//  Network.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire
import RxAlamofire
import RxSwift

typealias Json = [String: Any]

protocol APIRequest: URLRequestConvertible, URLConvertible {
    var method: HTTPMethod { get }
    var urlString: String { get }
}

extension APIRequest {
    func asURLRequest() throws -> URLRequest {
        return try URLRequest(url: urlString, method: method)
    }
}

extension APIRequest {
    func asURL() throws -> URL {
        guard let url = URL(string: "https://api.yelp.com/v3/" + urlString) else {
            throw NSError(domain: "", code: 9, userInfo: nil)
        }
        return url
    }
}

protocol Network {
    func requestJson(_ request: APIRequest) -> Observable<Json>
}
