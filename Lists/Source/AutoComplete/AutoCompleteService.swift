//
//  AutoCompleteService.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire

protocol AutoCompleteService {
    func getResults(request: AutoCompleteRequest,
                    completion: @escaping (Result<[AutoCompleteResult]>) -> Void)
}

struct RestaurantAutoCompleteService: AutoCompleteService {
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func getResults(request: AutoCompleteRequest,
                    completion: @escaping (Result<[AutoCompleteResult]>) -> Void) {
        network.requestJson(request) { result in
            completion(result.mapOptional { json -> [AutoCompleteResult]? in
                guard let terms = json["terms"] as? [Json] else {
                    print("Failed parsing autocomplete results: \(json)")
                    return nil
                }
                return terms.compactMap(AutoCompleteResult.init)
            })
        }
    }
}
