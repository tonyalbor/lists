//
//  RestaurantDetailService.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import RxSwift

protocol RestaurantDetailService {
    func getDetails(id: String) -> Observable<RestaurantDetailResult?>
}

struct YelpRestaurantDetailService: RestaurantDetailService {
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func getDetails(id: String) -> Observable<RestaurantDetailResult?> {
        let request = RestaurantDetailRequest(businessId: id)
        return network.requestJson(request)
            .map(RestaurantDetailResult.init)
    }
}
