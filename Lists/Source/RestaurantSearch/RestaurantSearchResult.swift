//
//  RestaurantSearchResult.swift
//  Lists
//
//  Created by Tony Albor on 8/18/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Foundation

struct RestaurantSearchResult {
    let total: Int
    let businesses: [Restaurant]
}

extension RestaurantSearchResult: Decodable {
    enum Keys: String, CodingKey {
        case total
        case businesses
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self = RestaurantSearchResult(total: try container.decode(Int.self, forKey: .total),
                                      businesses: try container.decode([Restaurant].self,
                                                                       forKey: .businesses))
    }
}
