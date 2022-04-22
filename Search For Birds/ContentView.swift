//
//  ContentView.swift
//  Search For Birds
//
//  Created by Kevin on 2/17/22.
//
import Combine
import CoreLocationUI
import CoreLocation
import SwiftUI
import MapKit

struct ContentView: View {
    @State private var mapType: MKMapType = .hybrid
    

    @ObservedObject private var locationManager = LocationManager()
    @StateObject private var viewModel = ContentViewModel()
    @State private var locations = [BirdAddLocation]()
    @State private var selectedPlace: BirdAddLocation?
    @State private var cancellable: AnyCancellable?
    var body:  some View {
        ZStack{
            
            Map( coordinateRegion: $viewModel.mapRegion, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil, annotationItems: locations) {location in MapAnnotation(coordinate: location.coordinate){
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
                setCurrentLocation()
            }
            Circle()
                .fill(.blue)
                .frame(width: 32, height:32)
        
            VStack {
                Spacer()
            
                HStack {
                    Spacer()
                    Button{
                        //creates new instance of Bird point
                        let newLocation = BirdAddLocation(id: UUID(), name: "", description: "", selectedBird: "", birdCount: "", latitude: viewModel.mapRegion.center.latitude, longitude: viewModel.mapRegion.center.longitude)
                        
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
   
                    }
            .sheet(item: $selectedPlace) {place in EditView(location: place){newLocation in
                if let index = locations.firstIndex(of: place){
                    locations[index] = newLocation
                    
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

        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.74289 , longitude: -81.32487), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
    private func setCurrentLocation(){
        cancellable = locationManager.$locate.sink { location in viewModel.mapRegion = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
                
    
 
        
        
    }

}
}

    


