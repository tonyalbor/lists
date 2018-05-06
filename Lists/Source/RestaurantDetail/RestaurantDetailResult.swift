//
//  RestaurantDetailResult.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Foundation

struct RestaurantDetailResult {
    let id: String
    let name: String
    let alias: String
    let imageUrl: URL
    let url: URL
    let price: String
    let rating: Double
    let reviewCount: Int
    let phone: String
    let photos: [URL]
    
    func printed() {
        print("id: \(id)\nname: \(name)\nalias: \(alias)\nprice: \(price)")
    }
}

extension RestaurantDetailResult {
    init?(json: Json) {
        guard let id = json["id"] as? String,
              let name = json["name"] as? String,
              let alias = json["alias"] as? String,
              let imageUrlString = json["image_url"] as? String,
              let imageUrl = URL(string: imageUrlString),
              let urlString = json["url"] as? String,
              let url = URL(string: urlString),
              let price = json["price"] as? String,
              let rating = json["rating"] as? Double,
              let reviewCount = json["review_count"] as? Int,
              let phone = json["phone"] as? String else {
                print("Warning: Failed parsing RestaurantDetailResult")
            return nil
        }
        
        let photoUrlStrings = json["photos"] as? [String] ?? []
        let photos = photoUrlStrings.compactMap(URL.init)
        
        if photoUrlStrings.count != photos.count {
            print("Warning: Mismatch in business photo urls")
        }
        
        self = RestaurantDetailResult(id: id,
                                      name: name,
                                      alias: alias,
                                      imageUrl: imageUrl,
                                      url: url,
                                      price: price,
                                      rating: rating,
                                      reviewCount: reviewCount,
                                      phone: phone,
                                      photos: photos)
    }
}
