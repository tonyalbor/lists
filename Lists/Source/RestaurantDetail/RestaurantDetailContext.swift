//
//  RestaurantDetailContext.swift
//  Lists
//
//  Created by Tony Albor on 5/28/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Foundation

class RestaurantDetailContext {
    
    private let apiClient: APIClient<RestaurantDetailResponse>
    private var detail: RestaurantDetailResponse?
    
    init(apiClient: APIClient<RestaurantDetailResponse>) {
        self.apiClient = apiClient
    }
    
    func getDetails(id: String,
                    completion: @escaping (Result<RestaurantDetailResponse>) -> Void) {
        let request = RestaurantDetailRequest(businessId: id)
        apiClient.request(request) { [weak self] result in
            self?.detail = result.value
            completion(result)
        }
    }
}
