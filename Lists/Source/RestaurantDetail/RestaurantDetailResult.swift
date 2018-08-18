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
}

extension RestaurantDetailResult: Decodable {
    enum Keys: String, CodingKey {
        case id
        case name
        case alias
        case imageUrl = "image_url"
        case url
        case price
        case rating
        case reviewCount = "review_count"
        case phone
        case photos
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self = RestaurantDetailResult(id: try container.decode(String.self, forKey: .id),
                                      name: try container.decode(String.self, forKey: .name),
                                      alias: try container.decode(String.self, forKey: .alias),
                                      imageUrl: try container.decode(URL.self, forKey: .imageUrl),
                                      url: try container.decode(URL.self, forKey: .url),
                                      price: try container.decode(String.self, forKey: .price),
                                      rating: try container.decode(Double.self, forKey: .rating),
                                      reviewCount: try container.decode(Int.self, forKey: .reviewCount),
                                      phone: try container.decode(String.self, forKey: .phone),
                                      photos: try container.decode([URL].self, forKey: .photos))
    }
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
