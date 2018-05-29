//
//  LocationManager.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import CoreLocation

typealias Coordinates = CLLocationCoordinate2D

protocol LocationManager {
    var isEnabled: Bool { get }
    func requestAccess()
    var currentCoordinates: Coordinates? { get }
}

class CoreLocationManager: NSObject, LocationManager {
    
    private let manager: CLLocationManager
    
    init(manager: CLLocationManager) {
        self.manager = manager
        super.init()
        self.manager.delegate = self
    }
    
    var isEnabled: Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    func requestAccess() {
        manager.requestWhenInUseAuthorization()
    }
    
    private(set) var currentCoordinates: Coordinates?
}

extension CoreLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentCoordinates = locations.last?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        let isNowEnabled = status == .authorizedWhenInUse
        
        if isNowEnabled {
            manager.startUpdatingLocation()
        }
    }
}
