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

protocol APIRequest: URLRequestConvertible {
    var method: HTTPMethod { get }
    var urlString: String { get }
}

extension APIRequest {
    func asURLRequest() throws -> URLRequest {
        return try URLRequest(url: urlString, method: method)
    }
}

protocol Network {
    func requestJson(_ request: APIRequest) -> Observable<Json>
}
