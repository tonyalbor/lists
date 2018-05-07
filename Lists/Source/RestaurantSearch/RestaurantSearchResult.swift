//
//  RestaurantSearchResult.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Foundation

struct RestaurantSearchResult {
    let id: String
    let name: String
    let alias: String
    let reviewCount: Int
    let urlString: String
    let imageUrl: URL
    let distance: Double
    let rating: Double
    let price: String
}

extension RestaurantSearchResult {
    init?(json: Json) {
        guard let id = json["id"] as? String,
              let name = json["name"] as? String,
              let alias = json["alias"] as? String,
              let reviewCount = json["review_count"] as? Int,
              let urlString = json["url"] as? String,
              let imageUrlString = json["image_url"] as? String,
              let imageUrl = URL(string: imageUrlString),
              let distance = json["distance"] as? Double,
              let rating = json["rating"] as? Double,
              let price = json["price"] as? String else {
            return nil
        }
        
        self = RestaurantSearchResult(id: id,
                                      name: name,
                                      alias: alias,
                                      reviewCount: reviewCount,
                                      urlString: urlString,
                                      imageUrl: imageUrl,
                                      distance: distance,
                                      rating: rating,
                                      price: price)
    }
}

extension RestaurantSearchResult: Equatable {}
func ==(lhs: RestaurantSearchResult, rhs: RestaurantSearchResult) -> Bool {
    return lhs.id == rhs.id && lhs.name == rhs.name
}
