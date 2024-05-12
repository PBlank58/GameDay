//
//  LSForwardsView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 17/4/2024.
//

import SwiftUI

struct LSForwardsView: View {

            //Custom Colours
            struct CustomGold {
                static let HC_Gold = Color("HC_Gold")
            }
            struct CustomMag {
                static let HC_Mag = Color("HC_Magenta")
            }
    @StateObject var scoreViewModel = ScoreViewModel()
    @StateObject var matchDetails: MatchViewModel
    
        @AppStorage("hcInside40") var hcInside40 = ""
        @State private var  hcInside40Array: [Int] = [0,0,0,0,0,0,0,0]
    
    @AppStorage("hcmarks") var hcmarks = ""
    @AppStorage("opmarks") var opmarks = ""
    
    @State private var hcMarksArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @State private var opMarksArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @State private var LaunchMatrixFrequencyFilter: [Int : Int] = [:]
    
    @AppStorage("tackles") var tackles = ""
    @State private var tacklesArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0]
    
    @State private var ScorePer1 = 0
    @State private var ScorePer2 = 0
    @State private var ScorePer3 = 0
    @State private var ScorePer4 = 0
    @State private var ScorePerT = 0
    
    var body: some View {
        HStack {
            Group {
                Text("HC Inside 40")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                Text("\(hcInside40Array[0] + hcInside40Array[4] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(hcInside40Array[1] + hcInside40Array[5] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(hcInside40Array[2] + hcInside40Array[6] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                 
                // Fourth Quarter
                Text("\(hcInside40Array[3] + hcInside40Array[7] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(hcInside40Array[0...7].reduce(0,+))")
                    .padding()
                    .frame(width: 100, height: 45)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                    .padding(.horizontal)
                   
            }
        }
        .font(.title2)
        HStack {
            Group {
                Text("Deep Entries")
                    .padding()
                    .frame(width: 260 , height: 45, alignment: .trailing)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                    .padding(.horizontal)
                // First Quarter
                Text("\(hcInside40Array[0])")
                
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(hcInside40Array[1])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(hcInside40Array[2])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                
                // Fourth Quarter
                Text("\(hcInside40Array[3])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(hcInside40Array[4...7].reduce(0,+))")
                
                    .padding()
                    .frame(width: 100, height: 45)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                    .padding(.horizontal)
                
            }
        }
        Divider()
            .overlay(CustomMag.HC_Mag)
            .frame(maxWidth: .infinity)
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
        HStack {
                Group {
                    Text("HC Marks in Attack ")
                        .padding()
                        .frame(width: 260, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.3))
                        .padding(.horizontal)
                    // First Quarter
                    Text("\(hcMarksArray[0] + hcMarksArray[4] )")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                    // Second Quarter
                    Text("\(hcMarksArray[1] + hcMarksArray[5] )")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    // Third Quarter
                    Text("\(hcMarksArray[2] + hcMarksArray[6] )")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                     
                    // Fourth Quarter
                    Text("\(hcMarksArray[3] + hcMarksArray[7] )")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    //Totals
                    Text("\(hcMarksArray[0...7].reduce(0,+))")
                        .padding()
                        .frame(width: 100, height: 45)
                        .background(CustomMag.HC_Mag.opacity(0.1))
                        .border(.gray)
                        .padding(.horizontal)
                       
                }
            }
            .font(.title2)
        HStack {
            Group {
                Text("\(matchDetails.matchArray.count == 0 ? "Op" : matchDetails.matchArray[0].oppAbbr.trimmingCharacters(in: .whitespacesAndNewlines)) Marks in Defence")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                Text("\(opMarksArray[0] + opMarksArray[4] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(opMarksArray[1] + opMarksArray[5] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(opMarksArray[2] + opMarksArray[6] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                 
                // Fourth Quarter
                Text("\(opMarksArray[3] + opMarksArray[7] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(opMarksArray[0...7].reduce(0,+))")
                    .padding()
                    .frame(width: 100, height: 45)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                    .padding(.horizontal)
                   
            }
        }
        .font(.title2)
        Divider()
            .overlay(CustomMag.HC_Mag)
            .frame(maxWidth: .infinity)
        HStack {
            Group {
                Text("Tackles inside 40")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                Text("\(tacklesArray[0] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(tacklesArray[1]  )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(tacklesArray[2] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                 
                // Fourth Quarter
                Text("\(tacklesArray[3]  )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(tacklesArray[0...3] .reduce(0,+))")
                    .padding()
                    .frame(width: 100, height: 45)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                    .padding(.horizontal)
                   
            }
        }
        .font(.title2)
            
            .onAppear() {
                UpdateForwardLS()
                        LaunchMatrixFrequencyFilter = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 124), 1) }, uniquingKeysWith: +)
                        scorePer()
                   
        }
    }
    func scorePer() {
      
        let scores1 = (LaunchMatrixFrequencyFilter[20] ?? 0 ) + (LaunchMatrixFrequencyFilter[24] ?? 0)
        let in40_1 = hcInside40Array[0] + hcInside40Array[4]
        let scores2 = (LaunchMatrixFrequencyFilter[52] ?? 0) + (LaunchMatrixFrequencyFilter[56] ?? 0)
        let in40_2 = hcInside40Array[1] + hcInside40Array[5]
        let scores3 = (LaunchMatrixFrequencyFilter[84] ?? 0) + (LaunchMatrixFrequencyFilter[88] ?? 0)
        let in40_3 = hcInside40Array[2] + hcInside40Array[6]
        let scores4 = (LaunchMatrixFrequencyFilter[116]) ?? 0 + (LaunchMatrixFrequencyFilter[120] ?? 0)
        let in40_4 = hcInside40Array[3] + hcInside40Array[7]
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
    func UpdateForwardLS() {
        // HcInside 40s
        if hcInside40 == "" {
            hcInside40 = "0,0,0,0,0,0,0,0"
            hcInside40Array = [0,0,0,0,0,0,0,0]
        } else {
            
            hcInside40Array = hcInside40.components(separatedBy: ",").map { Int($0) ?? 0 }
        }
        // HcMarks
        if hcmarks == "" {
            hcmarks = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
            hcMarksArray  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        } else {
            hcMarksArray = hcmarks.components(separatedBy: ",").map { Int($0) ?? 0  }
        }
        // OpMarks
        if opmarks == "" {
            opmarks = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
            opMarksArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        } else {
            opMarksArray = opmarks.components(separatedBy: ",").map { Int($0) ?? 0  }
        }
        // Tackles
        if tackles == "" {
            tackles = "0,0,0,0,0,0,0,0,0,0,0,0"
            tacklesArray = [0,0,0,0,0,0,0,0,0,0,0,0]
        } else {
            
            tacklesArray = tackles.components(separatedBy: ",").map { Int($0) ?? 0 }
        }
    }
}

#Preview {
    LSForwardsView(matchDetails: MatchViewModel())
}
