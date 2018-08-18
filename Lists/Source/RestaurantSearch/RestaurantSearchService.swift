//
//  RestaurantSearchService.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

protocol RestaurantSearchService {
    func getResults(request: APIRequest,
                    completion: @escaping (Result<[RestaurantSearchResult]>) -> Void)
}

struct YelpRestaurantSearchService: RestaurantSearchService {
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func getResults(request: APIRequest,
                    completion: @escaping (Result<[RestaurantSearchResult]>) -> Void) {
        
        
//        if let path = Bundle.main.path(forResource: "ExampleRestaurantsResponse", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let businesses = jsonResult["businesses"] as? [Json] {
//                    // do stuff
//                    let res = businesses.compactMap(RestaurantSearchResult.init)
//                    completion(.success(res))
//                    return
//                }
//            } catch {
//                // handle error
//            }
//        } else {
//            print("nice")
//        }
//        completion(.failure(NSError(domain: "nice", code: 0, userInfo: nil)))
        
        
        
        network.requestJson(request) { result in
            completion(result.mapOptional { json -> [RestaurantSearchResult]? in
                guard let businesses = json["businesses"] as? [Json] else {
                    return nil
                }
                return businesses.compactMap(RestaurantSearchResult.init)
            })
        }
    }
}
