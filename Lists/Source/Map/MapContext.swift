//
//  MapContext.swift
//  Lists
//
//  Created by Tony Albor on 8/4/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import CoreLocation

struct MapContext {
    let locationManager: LocationManager
    let annotations: [MapAnnotation]
    
    var currentCoordinates: Coordinates? {
        return locationManager.currentCoordinates
    }
}
