//
//  Network.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Foundation


// MARK: Requests

enum HttpMethod {
    case get
    case post
    case put
    case delete
}

protocol APIRequest {
    var method: HttpMethod { get }
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

    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: baseUrlString + urlString)!)
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
}


// MARK: Result

typealias Json = [String: Any]

enum Result<Value> {
    case success(Value)
    case failure(Error)
    
    var value: Value? {
        switch self {
        case let .success(v): return v
        case .failure: return nil
        }
    }
    
    func mapOptional<T>(_ transform: (Value) -> T?) -> Result<T> {
        switch self {
        case let .success(value):
            if let transformed = transform(value) {
                return .success(transformed)
            } else {
                // TODO: error details
                return .failure(NSError(domain: "Lists", code: 0, userInfo: nil))
            }
        case let .failure(error):
            return .failure(error)
        }
    }
}


// MARK: Networking

protocol Networking {
    func requestJson(_ request: APIRequest, completion: @escaping (Result<Json>) -> Void)
}

struct Network: Networking {
    
    static let `default` = Network(session: URLSession(configuration: .default))

    let session: URLSession
    
    func requestJson(_ request: APIRequest, completion: @escaping (Result<Json>) -> Void) {
        let task = session.dataTask(with: request.asURLRequest()) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse, let data = data else {
                completion(.failure(NSError(domain: "server error", code: 0, userInfo: nil)))
                return
            }
            guard let jsonTry = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any], let json = jsonTry else {
                completion(.failure(NSError(domain: "response json parsing error", code: 10, userInfo: nil)))
                return
            }
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(NSError(domain: "error response", code: 0, userInfo: json)))
                return
            }
            completion(.success(json))
        }
        task.resume()
    }
}
