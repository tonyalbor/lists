//
//  LocationManager.swift
//  Lists
//
//  Created by Tony Albor on 5/5/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import CoreLocation
import RxSwift

typealias Coordinates = CLLocationCoordinate2D

protocol LocationManager {
    func isEnabled() -> Observable<Bool>
    func requestAccess()
    func currentCoordinates() -> Observable<Coordinates?>
}

class CoreLocationManager: NSObject, LocationManager {
    
    private let manager: CLLocationManager
    private let isEnabledSubject: Variable<Bool> = Variable(false)
    private let currentLocationVariable: Variable<Coordinates?> = Variable(nil)
    
    init(manager: CLLocationManager) {
        self.manager = manager
        super.init()
        self.manager.delegate = self
    }
    
    func isEnabled() -> Observable<Bool> {
        isEnabledSubject.value = CLLocationManager.locationServicesEnabled()
        return isEnabledSubject.asObservable()
    }
    
    func requestAccess() {
        manager.requestWhenInUseAuthorization()
    }
    
    func currentCoordinates() -> Observable<Coordinates?> {
        return currentLocationVariable.asObservable()
    }
}

extension CoreLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocationVariable.value = locations.last?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        let isNowEnabled = status == .authorizedWhenInUse
        isEnabledSubject.value = isNowEnabled
        
        if isNowEnabled {
            manager.startUpdatingLocation()
        }
    }
}
