//
//  AutoCompleteTerm.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

struct AutoCompleteTerm {
    let text: String
}

extension AutoCompleteTerm: Decodable {
    enum Keys: String, CodingKey {
        case text
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self = AutoCompleteTerm(text: try container.decode(String.self, forKey: .text))
    }
    init?(json: Json) {
        guard let text = json["text"] as? String else {
            return nil
        }
        self = AutoCompleteTerm(text: text)
    }
}
