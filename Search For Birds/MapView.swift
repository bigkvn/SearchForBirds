//
//  ContentView.swift
//  Search For Birds
//
//  Created by Kevin on 2/17/22.
//

import SwiftUI
import MapKit
struct MapView: View {
    @StateObject private var viewModel = MapViewModel()

    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
        
            .onAppear{
                viewModel.checkLocalPerm()
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
final class MapViewModel: NSObject, ObservableObject,  CLLocationManagerDelegate {
    
    @Published  var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516 , longitude: -121.891054), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var locationManager: CLLocationManager?
    
    func checkLocateServ(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        }
        else{
            print("Enable Locatoin Services")
        }
    }
    func checkLocalPerm() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus{
                
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Access is restricted")
        case .denied:
            print("Access denied, please change location permissions from settings")
            
        case .authorizedAlways, .authorizedWhenInUse:
            
            region  = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan( latitudeDelta: 0.1, longitudeDelta: 0.1))
                                         
        
        @unknown default:
            break
        }

    }
    func locationChangeAuth( manager: CLLocationManager){
        checkLocalPerm()
    }
}

