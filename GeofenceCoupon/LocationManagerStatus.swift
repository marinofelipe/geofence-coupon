//
//  LocationManagerStatus.swift
//  GeofenceCoupon
//
//  Created by Felipe Marino on 03/08/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManagerStatus {
    
    static func checkIfLocationIsAuthorized(forLocationManager locationManager: CLLocationManager) {
        
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.classForCoder()) {
            let locationAuthorizationStatus   = CLLocationManager.authorizationStatus()
            
            switch locationAuthorizationStatus {
            case .authorizedAlways:
                return
            case .authorizedWhenInUse:
                return
            case .denied:
                return
            case .restricted:
                return
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
            }
        }
        else {
            print("geo redion npot supported")
        }
    }
}
