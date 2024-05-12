//
//  CompetitionDetails.swift
//  Hockey
//
//  Created by Brett Pullyblank on 03/1/2024.
//
import SwiftUI

class CompetitionModel: Identifiable , Codable, ObservableObject {
    var id = UUID()
    var competition = "APS"
  
}

@MainActor class CompetitionViewModel: ObservableObject {
    @Published var competitionArray: [CompetitionModel]

    let saveKey = "competition"
    init() {
        if let savedCompetition = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedItems = try? JSONDecoder().decode([CompetitionModel].self, from: savedCompetition) {
                competitionArray = decodedItems
                return
            }

        }
        //no saved data
        competitionArray = []
    }
  func saveCompetition() {
        if let encoded = try? JSONEncoder().encode(competitionArray) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
  
    func addCompetition(_ item: CompetitionModel) {
        competitionArray.append(item)
        saveCompetition()
    }
}
