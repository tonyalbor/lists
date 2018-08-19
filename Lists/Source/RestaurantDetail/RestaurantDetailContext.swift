//
//  RestaurantDetailContext.swift
//  Lists
//
//  Created by Tony Albor on 5/28/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Foundation

class RestaurantDetailContext {
    
    private let network: Network<RestaurantDetailResult>
    private var detail: RestaurantDetailResult?
    
    init(network: Network<RestaurantDetailResult>) {
        self.network = network
    }
    
    func getDetails(id: String,
                    completion: @escaping (Result<RestaurantDetailResult>) -> Void) {
        let request = RestaurantDetailRequest(businessId: id)
        network.request(request) { [weak self] result in
            self?.detail = result.value
            completion(result)
        }
    }
}
