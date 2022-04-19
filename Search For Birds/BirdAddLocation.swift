//
//  BirdAddLocation.swift
//  Search For Birds
//
//  Created by Kevin on 3/3/22.
//

import Foundation
import CoreLocation
struct BirdAddLocation: Identifiable, Codable, Equatable {
    
    let id: UUID
    var  name: String
    var description: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D{ CLLocationCoordinate2D(latitude: latitude, longitude: longitude)}
    
    static let example = BirdAddLocation(id: UUID(), name: "Hickory", description: "Test", latitude: 35.74289, longitude: -81.32487)
    
    static func ==(lhs: BirdAddLocation, rhs: BirdAddLocation) -> Bool{lhs.id == rhs.id}
}
