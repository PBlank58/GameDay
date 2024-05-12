//
//  PlayerDetails.swift
//  GameDay
//
//  Created by Brett Pullyblank on 1/9/2023.
//

import SwiftUI

class PlayerModel: Identifiable , Codable, ObservableObject {
    var id = UUID().uuidString
    var Surname = "Ah Mu"
    var Given = "Tarion"
    var Guernsey = 37
}

class PlayerViewModel: ObservableObject {
    @Published var playerArray: [PlayerModel]

    let saveKey = "player"
    init() {
        if let savedPlayer = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedItems = try? JSONDecoder().decode([PlayerModel].self, from: savedPlayer) {
                playerArray = decodedItems
                return
            }

        }
        //no saved data
        playerArray = []
    }
    func savePlayer() {
        if let encoded = try? JSONEncoder().encode(playerArray) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    func addPlayer(_ item: PlayerModel) {
        playerArray.append(item)
        savePlayer()
    }
}

