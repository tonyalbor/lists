//
//  AutoCompleteService.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import RxSwift

protocol AutoCompleteService {
    func getResults(query: String, coordinates: Coordinates) -> Observable<[AutoCompleteResult]>
}

struct RestaurantAutoCompleteService: AutoCompleteService {
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func getResults(query: String, coordinates: Coordinates) -> Observable<[AutoCompleteResult]> {
        let request = AutoCompleteRequest(query: query, coordinates: coordinates)
        return network.requestJson(request)
            .catchError({ (error) -> Observable<[String : Any]> in
                print(error)
                return .just([:])
            })
            .map { json -> [AutoCompleteResult] in
                guard let terms = json["terms"] as? [Json] else {
                    print("Failed parsing autocomplete results: \(json)")
                    return []
                }
                return terms.compactMap(AutoCompleteResult.init)
            }
    }
}
