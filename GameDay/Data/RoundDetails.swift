//
//  GameTitleDetails.swift
//  GameDay
//
//  Created by Brett Pullyblank on 3/1/2024.
//

import SwiftUI

class RoundModel: Identifiable ,  Codable, ObservableObject {
    
    var id = UUID().uuidString
    var Round = "1"
   
}

class RoundViewModel: ObservableObject {
    @Published var roundArray: [RoundModel]

    let saveKey = "round"
    init() {
        if let savedRound = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedItems = try? JSONDecoder().decode([RoundModel].self, from: savedRound) {
                roundArray = decodedItems
                return
            }
        }
        //no saved data
        roundArray = []
    }
    func saveRound() {
        if let encoded = try? JSONEncoder().encode(roundArray) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    func addRound(_ item: RoundModel) {
       roundArray.append(item)
        saveRound()
    }
}



