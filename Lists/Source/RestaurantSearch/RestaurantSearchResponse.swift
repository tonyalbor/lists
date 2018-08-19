//
//  RestaurantSearchResponse.swift
//  Lists
//
//  Created by Tony Albor on 8/18/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Foundation

struct RestaurantSearchResponse {
    let total: Int
    let businesses: [Restaurant]
}

extension RestaurantSearchResponse: Decodable {
    enum Keys: String, CodingKey {
        case total
        case businesses
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self = RestaurantSearchResponse(total: try container.decode(Int.self, forKey: .total),
                                      businesses: try container.decode([Restaurant].self,
                                                                       forKey: .businesses))
    }
}
