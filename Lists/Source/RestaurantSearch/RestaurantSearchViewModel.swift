//
//  RestaurantSearchViewModel.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire
import RxCocoa

class RestaurantSearchContext {
    
    let service: RestaurantSearchService
    let locationManager: LocationManager
    
    private(set) var results = [RestaurantSearchResult]()
    
    init(service: RestaurantSearchService, locationManager: LocationManager) {
        self.service = service
        self.locationManager = locationManager
    }
    
    func getResults(query: String,
                    completion: @escaping (Result<[RestaurantSearchResult]>) -> Void) {
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

struct RestaurantSearchViewModel: ViewModelType {
    
    struct Input {
        let query: Driver<String?>
    }
    
    struct Output {
        let results: Driver<[RestaurantSearchResult]>
    }
    
    private let searchService: RestaurantSearchService
    private let locationManager: LocationManager
    
    init(searchService: RestaurantSearchService, locationManager: LocationManager) {
        self.searchService = searchService
        self.locationManager = locationManager
    }
    
    func transform(input: Input) -> Output {
        return Output(results: .just([]))
//        let coordinates = locationManager.currentCoordinates()
//            .filter { $0 != nil }
//            .map { $0! }
//            .single()
//            .asDriver(onErrorJustReturn: Coordinates(latitude: 0, longitude: 0))
//        let results = Driver.combineLatest(input.query, coordinates)
//            .filter { $0.0 != nil }
//            .map { ($0.0!, $0.1) }
//            .distinctUntilChanged({ (lsh, rhs) -> Bool in
//                return true
//            })
//            .flatMap { combined -> Driver<[RestaurantSearchResult]> in
//                return .just([])
////                return self.searchService
////                    .getResults(query: combined.0, coordinates: combined.1, location: nil)
////                    .asDriver(onErrorJustReturn: [])
//            }
//        return Output(results: results)
    }
}
