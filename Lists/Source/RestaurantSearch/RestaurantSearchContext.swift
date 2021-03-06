//
//  RestaurantSearchContext.swift
//  Lists
//
//  Created by Tony Albor on 5/28/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

class RestaurantSearchContext {

    let apiClient: APIClient<RestaurantSearchResponse>
    let locationManager: LocationManager
    
    private(set) var results = [Restaurant]()
    
    init(apiClient: APIClient<RestaurantSearchResponse>, locationManager: LocationManager) {
        self.apiClient = apiClient
        self.locationManager = locationManager
    }
    
    func getResults(query: String,
                    completion: @escaping (Result<[Restaurant]>) -> Void) {
        let request = RestaurantSearchRequest(query: query,
                                              location: nil,
                                              coordinates: locationManager.currentCoordinates)
        apiClient.request(request) { [weak self] result in
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
