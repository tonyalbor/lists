//
//  RestaurantSearchViewModel.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import RxCocoa

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
        let coordinates = locationManager.currentCoordinates()
            .filter { $0 != nil }
            .map { $0! }
            .single()
            .asDriver(onErrorJustReturn: Coordinates(latitude: 0, longitude: 0))
        let results = Driver.combineLatest(input.query, coordinates)
            .filter { $0.0 != nil }
            .map { ($0.0!, $0.1) }
            .distinctUntilChanged({ (lsh, rhs) -> Bool in
                return true
            })
            .flatMap { combined -> Driver<[RestaurantSearchResult]> in
                return self.searchService
                    .getResults(query: combined.0, coordinates: combined.1, location: nil)
                    .asDriver(onErrorJustReturn: [])
            }
        return Output(results: results)
    }
}
