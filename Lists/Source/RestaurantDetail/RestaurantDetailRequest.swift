//
//  RestaurantDetailRequest.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

// https://www.yelp.com/developers/documentation/v3/business
struct RestaurantDetailRequest: YelpRequest {
    let method = HttpMethod.get
    var urlString: String {
        return "businesses/\(businessId)".urlEncoded()
    }
    
    let businessId: String
}
