//
//  RestaurantSearchService.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire
import RxSwift

//protocol RestaurantSearchService {
//    func getResults(query: String, coordinates: Coordinates?, location: String?) -> Observable<[RestaurantSearchResult]>
//}
//
//struct YelpRestaurantSearchService: RestaurantSearchService {
//
//    private let network: Network
//
//    init(network: Network) {
//        self.network = network
//    }
//
//    func getResults(query: String, coordinates: Coordinates?, location: String?) -> Observable<[RestaurantSearchResult]> {
//        let request = RestaurantSearchRequest(query: query, location: location, coordinates: coordinates)
//        return network.requestJson(request)
//            .catchError({ (error) -> Observable<[String : Any]> in
//                print(error)
//                return .just([:])
//            })
//            .map { json -> [RestaurantSearchResult] in
//                guard let businesses = json["businesses"] as? [Json] else {
//                    print("Failed parsing search results: \(json)")
//                    return []
//                }
//                return businesses.compactMap(RestaurantSearchResult.init)
//            }
//    }
//}

protocol RestaurantSearchService {
    func getResults(request: RestaurantSearchRequest, completion: @escaping (Result<[RestaurantSearchResult]>) -> Void)
}

struct YelpRestaurantSearchService: RestaurantSearchService {
    
    private let network: YelpNetworkV2
    
    init(network: YelpNetworkV2) {
        self.network = network
    }
    
    func getResults(request: RestaurantSearchRequest,
                    completion: @escaping (Result<[RestaurantSearchResult]>) -> Void) {
        network.requestJson(request) { result in
            switch result {
            case let .success(value):
                if let json = value as? Json {
                    if let businesses = json["businesses"] as? [Json] {
                        completion(.success(businesses.compactMap(RestaurantSearchResult.init)))
                        return
                    }
                }
                completion(.failure(NSError(domain: String(describing: type(of: self)),
                                            code: 0,
                                            userInfo: nil)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
