//
//  AutoCompleteViewModel.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import RxCocoa

class AutoCompleteViewModel: ViewModelType {
    
    struct Input {
        let query: Driver<String?>
    }
    
    struct Output {
        let results: Driver<[AutoCompleteResult]>
    }
    
    private let autoCompleteService: AutoCompleteService
    private let locationManager: LocationManager
    
    init(autoCompleteService: AutoCompleteService, locationManager: LocationManager) {
        self.autoCompleteService = autoCompleteService
        self.locationManager = locationManager
    }
    
    func transform(input: Input) -> Output {
        return Output(results: .just([]))
//        let coordinates = locationManager.currentCoordinates()
//            .filter { $0 != nil }
//            .map { $0! }
//            .asDriver(onErrorJustReturn: Coordinates(latitude: 0, longitude: 0))
//        let results = Driver.combineLatest(input.query, coordinates)
//            .filter { $0.0 != nil }
//            .map { ($0.0!, $0.1) }
//            .flatMap { combined -> Driver<[AutoCompleteResult]> in
//                return self.autoCompleteService
//                    .getResults(query: combined.0, coordinates: combined.1)
//                    .asDriver(onErrorJustReturn: [])
//            }
//        return Output(results: results)
    }
}
