//
//  RestaurantSearchRequest.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

// https://www.yelp.com/developers/documentation/v3/business_search
struct RestaurantSearchRequest: YelpRequest {
    let method = HttpMethod.get
    var urlString: String {
        var url = "businesses/search?term=\(query)"
        if let location = location {
            url += "&location=\(location)"
        }
        if let coordinates = coordinates {
            url += "&latitude=\(coordinates.latitude)"
            url += "&longitude=\(coordinates.longitude)"
        }
        url += "&categories=restaurants"
        return url.urlEncoded()
    }
    
    let query: String
    let location: String?
    let coordinates: Coordinates?
}

struct ListsRestaurantSearchRequest: ListsRequest {
    let method = HttpMethod.get
    let urlString = "restaurants"
}
