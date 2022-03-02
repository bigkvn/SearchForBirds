//
//  ContentView.swift
//  Search For Birds
//
//  Created by Kevin on 2/17/22.
//

import SwiftUI
import MapKit
struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:37.331516 , longitude: -121891054), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) )
    var body: some View {
        Map(coordinateRegion: $region)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
