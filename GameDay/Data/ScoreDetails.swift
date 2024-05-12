//
//  Scorearray.swift
//  GameDay
//
//  Created by Brett Pullyblank on 8/9/2023.
//

import SwiftUI

class ScoreModel: Identifiable , Codable, ObservableObject {
    var id = UUID().uuidString
    var quarter = "1"
    var team = "Haileybury"
    var scoreEvent = "Goal"
    var goalScorer = ""
    var scoreType = ""
    var HCWorm = 0
    var launchNummer = 0
    var typeNummer = 0
    var OpWorm = 0
    
  
   
}

class ScoreViewModel: ObservableObject {
    @Published var scoreArray: [ScoreModel]
    let saveKey = "score"
    init() {
        if let savedScoreDetails = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedItems = try? JSONDecoder().decode([ScoreModel].self, from: savedScoreDetails) {
                scoreArray = decodedItems
                return
            }

        }
        //no saved data
        scoreArray = []
    }
    func saveScore() {
        if let encoded = try? JSONEncoder().encode(scoreArray) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    func addScoreDetails(_ item: ScoreModel) {
        scoreArray.append(item)
        saveScore()
    }
    func resetAllScores() {
    // Remove Key-Value Pair
    UserDefaults.standard.removeObject(forKey: "score")
                                       }
}

