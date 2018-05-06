//
//  RestaurantDetailViewModel.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import RxCocoa

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
        let result = input.trigger
            .flatMap { id -> Driver<RestaurantDetailResult?> in
                return self.restaurantDetailService
                    .getDetails(id: id)
                    .asDriver(onErrorJustReturn: nil)
            }
            .filter { $0 != nil }
            .map { $0! }
        return Output(result: result)
    }
}
