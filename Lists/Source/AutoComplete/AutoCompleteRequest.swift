//
//  AutoCompleteRequest.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire

// https://www.yelp.com/developers/documentation/v3/autocomplete
struct AutoCompleteRequest: APIRequest {
    let method = HTTPMethod.get
    var urlString: String {
        let url = "autocomplete?text=\(query)&latitude=\(coordinates.latitude)&longitude=\(coordinates.longitude)"
        return url.urlEncoded()
    }
    
    let query: String
    let coordinates: Coordinates
}
