//
//  AutoCompleteResponse.swift
//  Lists
//
//  Created by Tony Albor on 8/18/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Foundation

struct AutoCompleteResponse {
    let terms: [AutoCompleteTerm]
}

extension AutoCompleteResponse: Decodable {
    enum Keys: String, CodingKey {
        case terms
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self = AutoCompleteResponse(terms: try container.decode([AutoCompleteTerm].self, forKey: .terms))
    }
}
