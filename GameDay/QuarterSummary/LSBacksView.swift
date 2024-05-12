//
//  LSBacksView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 17/4/2024.
//

import SwiftUI

struct LSBacksView: View {
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }
    @StateObject var scoreViewModel = ScoreViewModel()
    @StateObject var matchDetails: MatchViewModel
    
    @AppStorage("defence") var defence = ""
    @State private var defenceArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0]
    
    @AppStorage("opInside40") var opInside40 = ""
    @State private var  opInside40Array: [Int] = [0,0,0,0,0,0,0,0]
    
    @State private var LaunchMatrixFrequencyFilter: [Int : Int] = [:]
    // total view for row total
    @State private var LaunchMatrixFrequencyFilterRT: [Int : Int] = [:]
    @State private var ScorePer1 = 0
    @State private var ScorePer2 = 0
    @State private var ScorePer3 = 0
    @State private var ScorePer4 = 0
    @State private var ScorePerT = 0

    var body: some View {
        HStack {
            Group {
                Text("Inside 40s")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                
                Text("\(opInside40Array[0] + opInside40Array[4])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(opInside40Array[1] + opInside40Array[5] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(opInside40Array[2] + opInside40Array[6] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                 
                // Fourth Quarter
                Text("\(opInside40Array[3] + opInside40Array[7] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(opInside40Array[0...7].reduce(0,+))")
                    .padding()
                    .frame(width: 100, height: 45)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                    .padding(.horizontal)
                   
            }
        }
        .font(.title3)
        Divider()
        HStack {
            Group {
                Text("Score %")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                Text("\(ScorePer1)")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(ScorePer2)")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(ScorePer3)")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                 
                // Fourth Quarter
                Text("\(ScorePer4)")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
          
                Text("\(ScorePerT)")
                    .padding()
                    .frame(width: 100, height: 45)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                    .padding(.horizontal)
                   
            }
        }
        .font(.title3)
        Divider()
            .overlay(CustomMag.HC_Mag)
            .frame(maxWidth: .infinity)
        HStack {
            Group {
                Text("Marks from \(matchDetails.matchArray.count == 0 ? "Op" : matchDetails.matchArray[0].oppAbbr.trimmingCharacters(in: .whitespacesAndNewlines)) F40")
                        .padding()
                        .frame(width: 260, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.3))
                        .padding(.horizontal)
             
              //  First Quarter
                Text("\(defenceArray[0])")
                    .padding()
                    .frame(width: 70, height: 45)
                   .border(.gray)
                   .background(.gray.opacity(0.1))
               
               // Second Quarter
                Text("\(defenceArray[1])")
                    .padding()
                    .frame(width: 70, height: 45)
                   .border(.gray)
                   .background(.gray.opacity(0.1))
               // Third Quarter
                Text("\(defenceArray[2])")
                    .padding()
                    .frame(width: 70, height: 45)
                   .border(.gray)
                   .background(.gray.opacity(0.1))
             
               // Fourth Quarter
                Text("\(defenceArray[3])")
                    .padding()
                    .frame(width: 70, height: 45)
                   .border(.gray)
                   .background(.gray.opacity(0.1))
               //Totals
                Text("\(defenceArray[0..<4].reduce(0,+))")
                    .padding()
                    .frame(width: 100, height: 45)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                    .padding(.horizontal)
                   
            }
        }
        .font(.title3) 
        Divider()
            .overlay(CustomMag.HC_Mag)
            .frame(maxWidth: .infinity)
        HStack {
            Group {
                
                Text("Marks from \(matchDetails.matchArray.count == 0 ? "Op" : matchDetails.matchArray[0].oppAbbr.trimmingCharacters(in: .whitespacesAndNewlines)) Mid")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
              //  First Quarter
                Text("\(defenceArray[4])")
                    .padding()
                    .frame(width: 70, height: 45)
                   .border(.gray)
                   .background(.gray.opacity(0.1))
               
               // Second Quarter
                Text("\(defenceArray[5])")
                    .padding()
                    .frame(width: 70, height: 45)
                   .border(.gray)
                   .background(.gray.opacity(0.1))
               // Third Quarter
                Text("\(defenceArray[6])")
                    .padding()
                    .frame(width: 70, height: 45)
                   .border(.gray)
                   .background(.gray.opacity(0.1))
             
               // Fourth Quarter
                Text("\(defenceArray[7])")
                    .padding()
                    .frame(width: 70, height: 45)
                   .border(.gray)
                   .background(.gray.opacity(0.1))
               //Totals
                Text("\(defenceArray[4..<8].reduce(0,+))")
                    .padding()
                    .frame(width: 100, height: 45)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                    .padding(.horizontal)
                   
            }
        }
        .font(.title3) 
        HStack {
            Group {
               
                Text("Marks from \(matchDetails.matchArray.count == 0 ? "Op" : matchDetails.matchArray[0].oppAbbr.trimmingCharacters(in: .whitespacesAndNewlines)) B40")
                .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
              //  First Quarter
                Text("\(defenceArray[8])")
                    .padding()
                    .frame(width: 70, height: 45)
                   .border(.gray)
                   .background(.gray.opacity(0.1))
               // Second Quarter
                Text("\(defenceArray[9])")
                    .padding()
                    .frame(width: 70, height: 45)
                   .border(.gray)
                   .background(.gray.opacity(0.1))
               // Third Quarter
                Text("\(defenceArray[10])")
                    .padding()
                    .frame(width: 70, height: 45)
                   .border(.gray)
                   .background(.gray.opacity(0.1))
             
               // Fourth Quarter
                Text("\(defenceArray[11])")
                    .padding()
                    .frame(width: 70, height: 45)
                   .border(.gray)
                   .background(.gray.opacity(0.1))
               //Totals
                Text("\(defenceArray[8..<12].reduce(0,+))")
                    .padding()
                    .frame(width: 100, height: 45)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                    .padding(.horizontal)
                   
            }
        }
        .font(.title3)
        .onAppear() {
         
            updateDefenceArrays()
            LaunchMatrixFrequencyFilter = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 124), 1) }, uniquingKeysWith: +)
            //GrandTotals Row Totals
            LaunchMatrixFrequencyFilterRT = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 28), 1) }, uniquingKeysWith: +)
            scorePer()
        }
    }
    func scorePer() {
      
        let scores1 = (LaunchMatrixFrequencyFilter[4] ?? 0 ) + (LaunchMatrixFrequencyFilter[8] ?? 0)
        let in40_1 = opInside40Array[0] + opInside40Array[4]
        let scores2 = (LaunchMatrixFrequencyFilter[36] ?? 0) + (LaunchMatrixFrequencyFilter[40] ?? 0)
        let in40_2 = opInside40Array[1] + opInside40Array[5]
        let scores3 = (LaunchMatrixFrequencyFilter[68] ?? 0) + (LaunchMatrixFrequencyFilter[72] ?? 0)
        let in40_3 = opInside40Array[2] + opInside40Array[6]
        let scores4 = (LaunchMatrixFrequencyFilter[100]) ?? 0 + (LaunchMatrixFrequencyFilter[104] ?? 0)
        let in40_4 = opInside40Array[3] + opInside40Array[7]
        if in40_1 == 0 {
            ScorePer1 = 0 } else {
                ScorePer1 = Int(100 * scores1)/in40_1
                print("\(scores1) / \(in40_1))")
        }
        if in40_2 == 0 {
            ScorePer2 = 0 } else {
                ScorePer2 = Int(100 * scores2)/in40_2
                print("\(scores2) / \(in40_2))")
        }
        if in40_3 == 0 {
            ScorePer3 = 0 } else {
                ScorePer3 = Int(100 * scores3)/in40_3
                print("\(scores3) / \(in40_3))")
        }
        if in40_4 == 0 {
            ScorePer4 = 0 } else {
                ScorePer4 = Int(100 * scores4)/in40_4
                print("\(scores4) / \(in40_4))")
        }
        if in40_1 + in40_2 + in40_3 + in40_4 == 0 {
            ScorePerT = 0 } else {
                ScorePerT = Int(100 * (scores1 + scores2 + scores3 + scores4))/(in40_1 + in40_2 + in40_3 + in40_4)
        }
    }
    func updateDefenceArrays() {
                // Defence
                if defence == "" {
                    defence = "0,0,0,0,0,0,0,0,0,0,0,0"
                    defenceArray  = [0,0,0,0,0,0,0,0,0,0,0,0]
                } else {
                    defenceArray = defence.components(separatedBy: ",").map { Int($0) ?? 0 }
                }
        // OpInside 40s
        if opInside40 == "" {
            opInside40 = "0,0,0,0,0,0,0,0"
            opInside40Array = [0,0,0,0,0,0,0,0]
        } else {
            opInside40Array = opInside40.components(separatedBy: ",").map { Int($0) ?? 0 }
        }
    }
}

#Preview {
    LSBacksView(matchDetails: MatchViewModel())
}
