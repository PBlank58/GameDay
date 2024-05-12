//
//  LevelDetails.swift
//  GameDay
//
//  Created by Brett Pullyblank on 3/1/2024.
//

import SwiftUI

class LevelModel: Identifiable ,  Codable, ObservableObject {
    
    var id = UUID().uuidString
    var Grade = "1st XVIII"
   
}

class LevelViewModel: ObservableObject {
    @Published var levelArray: [LevelModel]

    let saveKey = "level"
    init() {
        if let savedLevel = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedItems = try? JSONDecoder().decode([LevelModel].self, from: savedLevel) {
                levelArray = decodedItems
                return
            }
        }
        //no saved data
        levelArray = []
    }
    func saveLevel() {
        if let encoded = try? JSONEncoder().encode(levelArray) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    func addLevel(_ item: LevelModel) {
        levelArray.append(item)
        saveLevel()
    }
}



