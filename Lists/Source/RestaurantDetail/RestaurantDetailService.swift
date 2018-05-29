//
//  RestaurantDetailService.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire

protocol RestaurantDetailService {
    func getDetails(request: RestaurantDetailRequest,
                    completion: @escaping (Result<RestaurantDetailResult>) -> Void)
}

struct YelpRestaurantDetailService: RestaurantDetailService {
    
    private let network: YelpNetworkV2
    
    init(network: YelpNetworkV2) {
        self.network = network
    }
    
    func getDetails(request: RestaurantDetailRequest,
                    completion: @escaping (Result<RestaurantDetailResult>) -> Void) {
        network.requestJson(request) { (result) in
            switch result {
            case let .success(value):
                if let json = value as? Json {
                    if let detail = RestaurantDetailResult(json: json) {
                        completion(.success(detail))
                    }
                }
                completion(.failure(NSError(domain: String(describing: type(of: self)),
                                            code: 0,
                                            userInfo: nil)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
