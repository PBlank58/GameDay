//
//  MatchDetails.swift
//  Hockey
//
//  Created by Brett Pullyblank on 15/5/2023.
//
import SwiftUI

class MatchModel: Identifiable , Codable, ObservableObject {
    var id = UUID()
    var gameDate = Date.now
    var competition = "APS"
    var home = "Haileybury"
    var homeAbbr = "HC"
    var venue = "HC_Keysborough"
    var opponent = "Opposition"
    var oppAbbr = "Op"
    var level = "1st XVIII"
    var round = "1"
    var launchArray: [Int] = []
}

@MainActor class MatchViewModel: ObservableObject {
    @Published var matchArray: [MatchModel]

    let saveKey = "match"
    init() {
        if let savedMatch = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedItems = try? JSONDecoder().decode([MatchModel].self, from: savedMatch) {
                matchArray = decodedItems
                return
            }

        }
        //no saved data
        matchArray = []
    }
  func saveMatch() {
        if let encoded = try? JSONEncoder().encode(matchArray) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
  
    func addMatch(_ item: MatchModel) {
        matchArray.append(item)
        saveMatch()
    }
}
