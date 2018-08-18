//
//  RestaurantSearchContext.swift
//  Lists
//
//  Created by Tony Albor on 5/28/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

class RestaurantSearchContext {
    
    let service: RestaurantSearchService
    let locationManager: LocationManager
    
    private(set) var results = [Restaurant]()
    
    init(service: RestaurantSearchService, locationManager: LocationManager) {
        self.service = service
        self.locationManager = locationManager
    }
    
    func getResults(query: String,
                    completion: @escaping (Result<[Restaurant]>) -> Void) {
        let request = RestaurantSearchRequest(query: query,
                                              location: nil,
                                              coordinates: locationManager.currentCoordinates)
        service.getResults(request: request) { result in
            if case let .success(results) = result {
                self.results = results
            }
            completion(result)
        }
    }
}
