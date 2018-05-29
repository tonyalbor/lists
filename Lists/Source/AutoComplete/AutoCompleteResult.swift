//
//  AutoCompleteResult.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

struct AutoCompleteResult {
    let text: String
}

extension AutoCompleteResult {
    init?(json: Json) {
        guard let text = json["text"] as? String else {
            return nil
        }
        self = AutoCompleteResult(text: text)
    }
}
