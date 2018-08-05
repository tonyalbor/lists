//
//  RestaurantSearchService.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire

protocol RestaurantSearchService {
    func getResults(request: APIRequest,
                    completion: @escaping (Result<[RestaurantSearchResult]>) -> Void)
}

struct YelpRestaurantSearchService: RestaurantSearchService {
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func getResults(request: APIRequest,
                    completion: @escaping (Result<[RestaurantSearchResult]>) -> Void) {
        network.requestJson(request) { result in
            completion(result.mapOptional { json -> [RestaurantSearchResult]? in
                guard let businesses = json["businesses"] as? [Json] else {
                    return nil
                }
                return businesses.compactMap(RestaurantSearchResult.init)
            })
        }
    }
}
