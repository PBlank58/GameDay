//
//  TimeDetails.swift
//  GameDay
//
//  Created by Brett Pullyblank on 20/9/2023.
//

import SwiftUI

class TimeModel: Identifiable , Codable, ObservableObject {
    var id = UUID().uuidString
    var quarter = "1"
    var time = "0:00"
   
  
   
}

class TimeViewModel: ObservableObject {
    @Published var timeArray: [TimeModel]

    let saveKey = "time"
    init() {
        if let savedTime = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedItems = try? JSONDecoder().decode([TimeModel].self, from: savedTime) {
                timeArray = decodedItems
                return
            }

        }
        //no saved data
       timeArray = []
    }
   
    func saveTime() {
        if let encoded = try? JSONEncoder().encode(timeArray) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    func addTime(_ item: TimeModel) {
        timeArray.append(item)
        saveTime()
    }
}


