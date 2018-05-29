//
//  RestaurantDetailContext.swift
//  Lists
//
//  Created by Tony Albor on 5/28/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire

class RestaurantDetailContext {
    
    private let service: RestaurantDetailService
    private var detail: RestaurantDetailResult?
    
    init(service: RestaurantDetailService) {
        self.service = service
    }
    
    func getDetails(id: String,
                    completion: @escaping (Result<RestaurantDetailResult>) -> Void) {
        let request = RestaurantDetailRequest(businessId: id)
        service.getDetails(request: request) { [weak self] result in
            self?.detail = result.value
            completion(result)
        }
    }
}
