//
//  ViewController.swift
//  GeofenceCoupon
//
//  Created by Felipe Marino on 01/08/17.
//  Copyright © 2017 Felipe Marino. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    fileprivate var businessRegion: CLCircularRegion?
    private var businessAnno: MKPointAnnotation?
    fileprivate var mapIsMoving = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManagerStatus.checkIfLocationIsAuthorized(forLocationManager: locationManager)
        setupLocationManager()
        setupBusinessRegion()
        setupAnnos()
        monitoreGeoRegion()
    }
    
    fileprivate func setupLocationManager() {
        locationManager.delegate = self
        if #available(iOS 9.0, *) {
            locationManager.allowsBackgroundLocationUpdates = true
        }
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 2
//        locationManager.startUpdatingLocation()
    }
    
    fileprivate func setupBusinessRegion() {
        businessRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 53.3454438, longitude: -6.2648819), radius: 5, identifier: "businessRegion")
        if #available(iOS 9.0, *) {
            locationManager.requestLocation()
        }
    }
    
    fileprivate func setupAnnos() {
        if let businessRegion = businessRegion {
            businessAnno = MKPointAnnotation()
            businessAnno?.coordinate = businessRegion.center
            businessAnno?.title = "Temple Bar Pub"
            mapView.addAnnotation(businessAnno!)
        }
    }
    
//    fileprivate func reverseGeocode() {
//        
//    }
    
    fileprivate func monitoreGeoRegion() {
        mapView.showsUserLocation = true
        if let businessRegion = businessRegion {
            locationManager.startMonitoring(for: businessRegion)
        }
        
//        mapView.showsUserLocation = false
//        if let businessRegion = businessRegion {
//            locationManager.stopMonitoring(for: businessRegion)
//        }
    }
    
    fileprivate func checkStatus() {
        locationManager.requestState(for: businessRegion!)
    }

}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("authorization status: \(status)")
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        //
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        var zoomRect = MKMapRectNull
//        for annotation in mapView.annotations {
//            let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
//            let pointRect: MKMapRect
//                if let title = annotation.title, title == "Temple Bar Pub" {
//                    pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y - 5000000, 0, 0)
//                }
//                else {
//                    pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y + 4000000, 0, 0)
//                }
//            if (MKMapRectIsNull(zoomRect)) {
//                zoomRect = pointRect
//            } else {
//                zoomRect = MKMapRectUnion(zoomRect, pointRect)
//            }
//        }
//        mapView.setVisibleMapRect(zoomRect, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("failed with error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        //offer coupon
        //TODO: Change notification code to another class
        if #available(iOS 10.0, *) {
            //TODO: ...
        }
        else {
            let notification = UILocalNotification()
            if #available(iOS 8.2, *) {
                notification.alertTitle = "Visit Temple Bar"
            }
            notification.alertBody = "We have the best paints for you and your friends. Just come in and fill welcomed."
            notification.fireDate = Date(timeIntervalSinceNow: 1)
            notification.repeatInterval = .minute
            notification.applicationIconBadgeNumber += 1
            
            UIApplication.shared.cancelAllLocalNotifications()
            UIApplication.shared.scheduledLocalNotifications = [notification]
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        //remove coupon
        UIApplication.shared.cancelAllLocalNotifications()
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        print("state: \(state) of region: \(region)")
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        mapIsMoving = true
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapIsMoving = false
    }
}
