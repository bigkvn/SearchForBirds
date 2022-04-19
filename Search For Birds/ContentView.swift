//
//  ContentView.swift
//  Search For Birds
//
//  Created by Kevin on 2/17/22.
//
import CoreLocationUI
import CoreLocation
import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    @State private var locations = [BirdAddLocation]()
    @State private var selectedPlace: BirdAddLocation?
    
    var body: some View {
        ZStack{
            
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locations) {location in MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude )){
            VStack{
                Image(systemName: "star.circle")
                    .resizable()
                    .foregroundColor(.blue)
                    .frame(width: 44, height: 44)
                    .background(.white)
                    .clipShape(Circle())
                Text(location.name)
                	
                }
            .onTapGesture{selectedPlace = location }
            }

        }
            .ignoresSafeArea()
            .onAppear{
                viewModel.checkLocalPerm()
            }
            Circle()
                .fill(.blue)
                .frame(width: 32, height:32)
        
            VStack {
                Spacer()
            
                HStack {
                    Spacer()
                    Button{
                        let newLocation = BirdAddLocation(id: UUID(), name: "New Location", description: "", latitude: viewModel.region.center.latitude, longitude: viewModel.region.center.latitude)
                        locations.append(newLocation)
                   
                    } label: {
                        Image(systemName: "plus")

                    .padding()
                    .background(.blue.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                    
                }
                    
                    
            }
            .sheet(item: $selectedPlace) {place in EditView(location: place){newLocation in
                if let index = locations.firstIndex(of: place){
                    locations[index] = newLocation
                    
                }
            }
                	 
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
final class ContentViewModel: NSObject, ObservableObject,  CLLocationManagerDelegate {
    @Published  var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.74289 , longitude: -81.32487), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var locationManager:  CLLocationManager?
    
    func checkLocateServ(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self    }
        else{
            print("Enable Location Services")
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
}

