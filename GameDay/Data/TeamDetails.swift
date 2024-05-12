//
//  OppositionDetails.swift
//  GameDay
//
//  Created by Brett Pullyblank on 3/1/2024.
//
import SwiftUI

class TeamModel: Identifiable , Codable, ObservableObject {
    var id = UUID()
    var Team = "Brighton"
    var TeamAbbr = "BR"
  
}

@MainActor class TeamViewModel: ObservableObject {
    @Published var teamArray: [TeamModel]

    let saveKey = "team"
    init() {
        if let savedTeam = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedItems = try? JSONDecoder().decode([TeamModel].self, from: savedTeam) {
                teamArray = decodedItems
                return
            }

        }
        //no saved data
        teamArray = []
    }
  func saveTeam() {
        if let encoded = try? JSONEncoder().encode(teamArray) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
  
    func addTeam(_ item: TeamModel) {
        teamArray.append(item)
        saveTeam()
    }
}
