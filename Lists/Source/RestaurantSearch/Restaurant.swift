//
//  Restaurant.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Foundation

struct Restaurant {
    let id: String
    let name: String
    let alias: String
    let reviewCount: Int
    let urlString: String
    let imageUrl: URL
    let distance: Double
    let rating: Double
    let price: String
    let coordinates: Coordinates
}

extension Restaurant: Decodable {
    enum Keys: String, CodingKey {
        case id
        case name
        case alias
        case reviewCount = "review_count"
        case urlString = "url"
        case imageUrl = "image_url"
        case distance
        case rating
        case price
        case coordinates
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self = Restaurant(id: try container.decode(String.self, forKey: .id),
                                      name: try container.decode(String.self, forKey: .name),
                                      alias: try container.decode(String.self, forKey: .alias),
                                      reviewCount: try container.decode(Int.self,
                                                                        forKey: .reviewCount),
                                      urlString: try container.decode(String.self, forKey: .urlString),
                                      imageUrl: try container.decode(URL.self, forKey: .imageUrl),
                                      distance: try container.decode(Double.self, forKey: .distance),
                                      rating: try container.decode(Double.self, forKey: .rating),
                                      price: (try? container.decode(String.self, forKey: .price))
                                        ?? "nil",
                                      coordinates: try container.decode(Coordinates.self,
                                                                        forKey: .coordinates))
    }
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
              let price = json["price"] as? String,
              let coordinatesData = json["coordinates"] as? [String: Any],
              let longitude = coordinatesData["longitude"] as? Double,
              let latitude = coordinatesData["latitude"] as? Double else {
            print("Failed Restaurant Search Result init")
            return nil
        }
        self = Restaurant(id: id,
                                      name: name,
                                      alias: alias,
                                      reviewCount: reviewCount,
                                      urlString: urlString,
                                      imageUrl: imageUrl,
                                      distance: distance,
                                      rating: rating,
                                      price: price,
                                      coordinates: Coordinates(latitude: latitude, longitude: longitude))
    }
}

extension Restaurant: Equatable {}
func ==(lhs: Restaurant, rhs: Restaurant) -> Bool {
    return lhs.id == rhs.id && lhs.name == rhs.name
}
