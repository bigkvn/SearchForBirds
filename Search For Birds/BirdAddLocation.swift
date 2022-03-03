//
//  BirdAddLocation.swift
//  Search For Birds
//
//  Created by Kevin on 3/3/22.
//

import Foundation
struct BirdAddLocation: Identifiable, Codable, Equatable {
    
    let id: UUID
    var  name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    
}
