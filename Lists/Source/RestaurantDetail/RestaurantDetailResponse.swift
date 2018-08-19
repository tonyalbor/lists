//
//  RestaurantDetailResponse.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Foundation

struct RestaurantDetailResponse {
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

extension RestaurantDetailResponse: Decodable {

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
        self = RestaurantDetailResponse(id: try container.decode(String.self, forKey: .id),
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
}
