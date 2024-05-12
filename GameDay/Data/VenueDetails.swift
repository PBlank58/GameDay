//
//  VenueDetails.swift
//  Hockey
//
//  Created by Brett Pullyblank on 03/1/2024.
//
import SwiftUI

class VenueModel: Identifiable , Codable, ObservableObject {
    var id = UUID()
    var venue = "Keysborough"
  
}

@MainActor class VenueViewModel: ObservableObject {
    @Published var venueArray: [VenueModel]

    let saveKey = "venue"
    init() {
        if let savedVenue = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedItems = try? JSONDecoder().decode([VenueModel].self, from: savedVenue) {
                venueArray = decodedItems
                return
            }

        }
        //no saved data
        venueArray = []
    }
  func saveVenue() {
        if let encoded = try? JSONEncoder().encode(venueArray) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
  
    func addVenue(_ item: VenueModel) {
        venueArray.append(item)
        saveVenue()
    }
}
