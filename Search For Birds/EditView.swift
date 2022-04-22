//
//  EditView.swift
//  Search For Birds
//
//  Created by Kevin on 3/4/22.
//

import Foundation
import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    var location: BirdAddLocation
    var onSave: (BirdAddLocation) -> Void
    
    @State private var name: String
    @State private var description: String
    @State private var birdCount: String
  
    @State private var selected = "select"
    var birdTypeList = ["Whooping Crane", "Sandhill Crane, Wood Stork", "Roseate Spoonball", "Cattle Egret", "Great Egret", "Snowy Egret", "Little Blue Heron (Blue)", "Little Blue Heron (imm. White)", "Little Blue Heron (Calico)", "Great Blue Heron", "Great White Heron", "Reddish Egret", "Tricolor Heron", "Black-crowned Night Heron", "Yellow-crowned Night Heron", "Green Heron", "White Ibis", "Green Ibis", "White-faced Ibis" ]
    
    var body: some View{
        NavigationView{
            Form{
                Section{
                    TextField("Place name", text: $name)
                    TextField("Describe the location", text: $description)
                    Picker ("What bird did you spot? ", selection: $selected){
                        ForEach(birdTypeList, id: \.self){
                            Text($0)
                        }
                    }
                    TextField("How man birds did you spot? ", text: $birdCount)
                    
                }
            }
            .navigationTitle("Bird location")
            .toolbar{
                //saves new bird location
                Button("Save"){
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.birdCount = birdCount
                    newLocation.description = description
                    newLocation.selectedBird = selected
                    
                    onSave(newLocation)
                    
                    dismiss()
                }
            }
        }
    }

    init(location: BirdAddLocation, onSave: @escaping(BirdAddLocation) -> Void ){
        self.location = location
        self.onSave = onSave
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
        _selected = State(initialValue: location.selectedBird)
        _birdCount = State(initialValue: location.birdCount)
    }
}

