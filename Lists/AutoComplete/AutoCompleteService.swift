//
//  AutoCompleteService.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import RxSwift

protocol AutoCompleteService {
    func getResults(query: String, location: Location) -> Observable<[AutoCompleteResult]>
}

struct RestaurantAutoCompleteService: AutoCompleteService {
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func getResults(query: String, location: Location) -> Observable<[AutoCompleteResult]> {
        let request = AutoCompleteRequest(query: query, location: location)
        return network.requestJson(request)
            .catchError({ (error) -> Observable<[String : Any]> in
                print(error)
                return .just([:])
            })
            .map { json -> [AutoCompleteResult] in
                guard let terms = json["terms"] as? [Json] else {
                    print("Failed parsing json: \(json)")
                    return []
                }
                
                return terms.flatMap(AutoCompleteResult.init)
            }
    }
}
