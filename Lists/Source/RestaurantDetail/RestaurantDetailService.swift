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
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func getDetails(request: RestaurantDetailRequest,
                    completion: @escaping (Result<RestaurantDetailResult>) -> Void) {
        network.requestJson(request) { (result) in
            completion(result.mapOptional(RestaurantDetailResult.init))
        }
    }
}
