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

enum HttpMethod {
    case get
    
    var toAlamofireMethod: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }
}

typealias Json = [String: Any]

protocol APIRequest: URLRequestConvertible {
    var method: HttpMethod { get }
    var urlString: String { get }
}

extension APIRequest {
    func asURLRequest() throws -> URLRequest {
        return try URLRequest(url: urlString, method: method.toAlamofireMethod)
    }
}

protocol Network {
    func requestJson(_ request: APIRequest) -> Observable<Json>
}
