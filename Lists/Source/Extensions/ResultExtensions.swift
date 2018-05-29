//
//  ResultExtensions.swift
//  Lists
//
//  Created by Tony Albor on 5/28/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire

extension Result {
    
    func mapOptional<T>(_ transform: (Value) -> T?) -> Result<T> {
        switch self {
        case let .success(value):
            if let transformed = transform(value) {
                return .success(transformed)
            } else {
                // TODO: error details
                return .failure(NSError())
            }
        case let .failure(error):
            return .failure(error)
        }
    }
}
