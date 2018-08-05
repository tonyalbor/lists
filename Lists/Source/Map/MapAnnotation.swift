//
//  MapAnnotation.swift
//  Lists
//
//  Created by Tony Albor on 8/4/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    let coordinate: Coordinates
    let title: String?
    let subtitle: String?
    
    init(coordinate: Coordinates, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
