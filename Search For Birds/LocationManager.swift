//
//  LocationManager.swift
//  Search For Birds
//
//  Created by Kevin Rendon on 4/22/22.
//
import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject{
    

let locationManager = CLLocationManager()
@Published var locate: CLLocation?

override init() {
    super.init()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = kCLDistanceFilterNone
    locationManager.requestAlwaysAuthorization()
    locationManager.startUpdatingLocation()
    locationManager.delegate = self
    
    
}
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locate = locations.last else {return}
        DispatchQueue.main.async {
            self.locate = locate 
        }
    }
}
