//
//  RestaurantSearchService.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import RxSwift

protocol RestaurantSearchService {
    func getResults(query: String, coordinates: Coordinates?, location: String?) -> Observable<[RestaurantSearchResult]>
}

struct YelpRestaurantSearchService: RestaurantSearchService {
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func getResults(query: String, coordinates: Coordinates?, location: String?) -> Observable<[RestaurantSearchResult]> {
        let request = RestaurantSearchRequest(query: query, location: location, coordinates: coordinates)
        return network.requestJson(request)
            .catchError({ (error) -> Observable<[String : Any]> in
                print(error)
                return .just([:])
            })
            .map { json -> [RestaurantSearchResult] in
                guard let businesses = json["businesses"] as? [Json] else {
                    print("Failed parsing search results: \(json)")
                    return []
                }
                return businesses.compactMap(RestaurantSearchResult.init)
            }
    }
}
