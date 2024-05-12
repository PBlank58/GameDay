//
//  KPIDetails.swift
//  GameDay
//
//  Created by Brett Pullyblank on 18/9/2023.
//

import SwiftUI

class KPI: Identifiable , Codable, ObservableObject {
   
    
    var id = UUID()
    var clearances = "0"
    var contested = "0"
    var tackles = "0"
    var missedTackles = "0"
    var marksHC = "0"
    var marksOp = "0"
    var insideHC = "0"
    var insideOp = "0"
    var repeatS = "0"
    var pressur = "0"
    var extraKPI = "0"
}

@MainActor class KPIDetails: ObservableObject {
    @Published var KPIdetails: [KPI]

    let saveKey = "kpi"
    init() {
        if let savedGame = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedItems = try? JSONDecoder().decode([KPI].self, from: savedGame) {
                KPIdetails = decodedItems
                return
            }

        }
        //no saved data
        KPIdetails = []
    }
    private func saveKPI() {
        if let encoded = try? JSONEncoder().encode(KPIdetails) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    func addKPI(_ item: KPI) {
        KPIdetails.append(item)
        saveKPI()
    }
}

