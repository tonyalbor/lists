//
//  ViewController.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import CoreLocation
import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
//        testSearch()
//        testAutocomplete()
        testBusinessDetails()
    }
    
    private func testAutocomplete() {
        let yelp = YelpNetwork()
        let yelpService = RestaurantAutoCompleteService(network: yelp)
        let locationManager = CoreLocationManager(manager: CLLocationManager())
        locationManager.requestAccess()
        
        let viewModel = AutoCompleteViewModel(autoCompleteService: yelpService, locationManager: locationManager)
        
        let input: Driver<String?> = Driver.just("Spin Fish Poke House")
        
        let output = viewModel.transform(input: AutoCompleteViewModel.Input(query: input))
        
        output.results
            .drive(onNext: { (results) in
                results.forEach({ (result) in
                    print("autocomplete result: \(result.text)")
                })
            })
            .disposed(by: disposeBag)
    }
    
    private func testSearch() {
        let yelp = YelpNetwork()
        let yelpService = YelpRestaurantSearchService(network: yelp)
        let locationManager = CoreLocationManager(manager: CLLocationManager())
        locationManager.requestAccess()
        
        let viewModel = RestaurantSearchViewModel(searchService: yelpService, locationManager: locationManager)
        
        let input: Driver<String?> = Driver.just("Spin Fish Poke House")
        
        let output = viewModel.transform(input: RestaurantSearchViewModel.Input(query: input))
        
        output.results
            .drive(onNext: { (results) in
                results.forEach({ (result) in
                    print("search result: \(result.name), id: \(result.id)")
                })
            })
            .disposed(by: disposeBag)
    }
    
    private func testBusinessDetails() {
        let yelp = YelpNetwork()
        let yelpService = YelpRestaurantDetailService(network: yelp)
        let viewModel = RestaurantDetailViewModel(restaurantDetailService: yelpService)
        let input = RestaurantDetailViewModel.Input(trigger: .just("PEBwHTrSJxJDnLMuo3hziQ"))
        let output = viewModel.transform(input: input)
        output.result
            .drive(onNext: { (result) in
                result.printed()
            })
            .disposed(by: disposeBag)
    }
}
