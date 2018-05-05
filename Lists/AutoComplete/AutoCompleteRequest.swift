//
//  AutoCompleteRequest.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire

struct AutoCompleteRequest: APIRequest {
    let method = HttpMethod.get
    var urlString: String {
        let url = "autocomplete?text=\(query)&latitude=\(location.latitude)&longitude=\(location.longitude)"
        return url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    let query: String
    let location: Location
}
