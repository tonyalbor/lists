//
//  Network.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire

typealias Json = [String: Any]


// MARK: Requests

protocol APIRequest: URLConvertible {
    var method: HTTPMethod { get }
    var baseUrlString: String { get }
    var urlString: String { get }
    var headers: [String: String] { get }
}

protocol YelpRequest: APIRequest {}
protocol ListsRequest: APIRequest {}

extension YelpRequest {
    var baseUrlString: String { return "https://api.yelp.com/v3/" }
    
    var headers: [String: String] {
        return ["Authorization": "Bearer" + " " + YelpApiKey.app]
    }
}

extension ListsRequest {
    var baseUrlString: String { return "http://localhost:8080/" }
    
    var headers: [String: String] {
        let credentialData = "hirving:lozano".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        return ["Authorization": "Basic \(base64Credentials)"]
    }
}

extension APIRequest {
    func asURL() throws -> URL {
        guard let url = URL(string: baseUrlString + urlString) else {
            throw NSError(domain: "", code: 9, userInfo: nil)
        }
        return url
    }
}


// MARK: Networking

protocol Networking {
    func requestJson(_ request: APIRequest, completion: @escaping (Result<Json>) -> Void)
}

struct Network: Networking {
    
    let sessionManager: SessionManager
    
    func requestJson(_ request: APIRequest, completion: @escaping (Result<Json>) -> Void) {
        sessionManager.request(request,
                               method: request.method,
                               parameters: nil,
                               encoding: URLEncoding.default,
                               headers: request.headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                do {
                    if let rawResponse = response.data,
                        let json = try JSONSerialization.jsonObject(with: rawResponse,
                                                                    options: .allowFragments) as? [String: Any] {
                        completion(.success(json))
                        return
                    }
                } catch {
                    // don't need to do anything
                    print("damn")
                }
                completion(response.result.mapOptional { $0 as? Json })
        }
    }
}

struct TestRequest: ListsRequest {
    let method = HTTPMethod.get
    let urlString = "lists"
}
