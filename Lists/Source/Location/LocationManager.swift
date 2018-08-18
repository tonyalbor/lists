//
//  LocationManager.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import CoreLocation

typealias Coordinates = CLLocationCoordinate2D

extension Coordinates: Decodable {
    enum Keys: String, CodingKey {
        case longitude
        case latitude
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self = Coordinates(latitude: try container.decode(Double.self, forKey: .latitude),
                           longitude: try container.decode(Double.self, forKey: .longitude))
    }
}

protocol LocationManager {
    var isEnabled: Bool { get }
    func requestAccess()
    var currentCoordinates: Coordinates? { get }
}

class CoreLocationManager: NSObject, LocationManager {
    
    private let manager: CLLocationManager
    private(set) var currentCoordinates: Coordinates?
    
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
}

extension CoreLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentCoordinates = locations.last?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}
