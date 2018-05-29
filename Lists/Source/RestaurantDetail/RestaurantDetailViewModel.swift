//
//  RestaurantDetailViewModel.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire
import RxCocoa

class RestaurantDetailContext {
    
    private let service: RestaurantDetailService
    private var detail: RestaurantDetailResult?
    
    init(service: RestaurantDetailService) {
        self.service = service
    }
    
    func getDetails(id: String, completion: @escaping (Result<RestaurantDetailResult>) -> Void) {
        let request = RestaurantDetailRequest(businessId: id)
        service.getDetails(request: request) { [weak self] result in
            self?.detail = result.value
            completion(result)
        }
    }
}

class RestaurantDetailViewModel: ViewModelType {
    
    struct Input {
        let trigger: Driver<String>
    }
    
    struct Output {
        let result: Driver<RestaurantDetailResult>
    }
    
    private let restaurantDetailService: RestaurantDetailService
    
    init(restaurantDetailService: RestaurantDetailService) {
        self.restaurantDetailService = restaurantDetailService
    }
    
    func transform(input: Input) -> Output {
        return Output(result: .just(RestaurantDetailResult(json: [:])!))
//        let result = input.trigger
//            .flatMap { id -> Driver<RestaurantDetailResult?> in
//                return self.restaurantDetailService
//                    .getDetails(id: id)
//                    .asDriver(onErrorJustReturn: nil)
//            }
//            .filter { $0 != nil }
//            .map { $0! }
//        return Output(result: result)
    }
}
