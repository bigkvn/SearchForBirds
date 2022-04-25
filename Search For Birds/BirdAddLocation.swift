//
//  BirdAddLocation.swift
//  Search For Birds
//
//  Created by Kevin on 3/3/22.
//

import Foundation
import CoreLocation
struct BirdAddLocation: Identifiable, Codable, Equatable {
    
    var  id: UUID
    var  name: String
    var description: String 
    var selectedBird: String
    var birdCount: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D{ CLLocationCoordinate2D(latitude: latitude, longitude: longitude)}
    
   
    static func ==(lhs: BirdAddLocation, rhs: BirdAddLocation) -> Bool{lhs.id == rhs.id}
}
