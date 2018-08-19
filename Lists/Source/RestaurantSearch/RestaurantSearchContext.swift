//
//  RestaurantSearchContext.swift
//  Lists
//
//  Created by Tony Albor on 5/28/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

class RestaurantSearchContext {
    
    let network: Network<RestaurantSearchResult>
    let locationManager: LocationManager
    
    private(set) var results = [Restaurant]()
    
    init(network: Network<RestaurantSearchResult>, locationManager: LocationManager) {
        self.network = network
        self.locationManager = locationManager
    }
    
    func getResults(query: String,
                    completion: @escaping (Result<[Restaurant]>) -> Void) {
        let request = RestaurantSearchRequest(query: query,
                                              location: nil,
                                              coordinates: locationManager.currentCoordinates)
        network.request(request) { [weak self] result in
            if case let .success(result) = result {
                self?.results = result.businesses
            }
            let thisResult: Result<[Restaurant]>
            switch result {
            case let .success(result):
                thisResult = .success(result.businesses)
            case let .failure(error):
                thisResult = .failure(error)
            }
            completion(thisResult)
        }
    }
}
