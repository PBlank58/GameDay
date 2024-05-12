//
//  QuarterSummaryView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 4/9/2023.
//

import SwiftUI

struct QuarterSummaryView: View {
    @StateObject var timeViewModel = TimeViewModel()
    @StateObject var teamViewModel = PlayerViewModel()
    @StateObject var matchDetails: MatchViewModel
    @Environment(\.dismiss) private var dismiss
    
    
    @StateObject var scoreViewModel = ScoreViewModel()
    @State private var goalFreqArray: [String : Int] = [:]
    @State private var csvGKList = ""
    
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }
    // Collect all AppStorage data
    @State private var isReset = false
    @State private var showQtimes = false
    @State private var showCSVBool = false
    
    // MARK: PDF properties
    @State var PDFURL: URL?
    @State var showPDFSheet: Bool = false
    @State var notShowPDFSheet: Bool = true
    
    // csv export
    //clearances
    @AppStorage("clearance") var clearance = ""
    @State var clearanceArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @State var csvCentreCearanceArray: [Int]  = [0,0,0,0]
    @AppStorage("CsvCentreClearance") var csvCentreClearance = ""
    @State var csvOtherCearanceArray: [Int]  = [0,0,0,0]
    @AppStorage("CsvOtherClearance") var csvOtherClearance = ""
    
    
    //contested
    @AppStorage("contested") var contested = ""
    @State private var contestedArray: [Int]  = [0,0,0,0,0,0,0,0]
    @State private var csvContestedArray: [Int]  = [0,0,0,0]
    @AppStorage("CsvContested") var csvContested = ""
    
    //tackles
    @AppStorage("tackles") var tackles = ""
    @State private var tacklesArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0]
    @AppStorage("inside40Tackles") var inside40Tackles = ""
    @State var csvInside40TacklesArray: [Int]  = [0,0,0,0]
    @State var csvTotalTacklesArray: [Int]  = [0,0,0,0]
    
    // marks
    @AppStorage("hcmarks") var hcmarks = ""
    @AppStorage("opmarks") var opmarks = ""
    
    @State private var hcMarksArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @State private var opMarksArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    @AppStorage("totalMarks") var totalMarks = ""
    @State var totalMarksArray: [Int]  = [0,0,0,0]
    
    //Inside 40 Us
    @AppStorage("hcInside40") var hcInside40 = ""
    @State private var  hcInside40Array: [Int] = [0,0,0,0,0,0,0,0]
    @AppStorage("hcInside40Us") var hcInside40Us = ""
    @State private var  csvInside40UsArray: [Int] = [0,0,0,0]
    @AppStorage("Inside40UsShallow") var Inside40UsShallow = ""
    @State private var  csvInside40UsShallowArray: [Int] = [0,0,0,0]
    
    //Inside 40 them
    @AppStorage("opInside40") var opInside40 = ""
    @State private var  opInside40Array: [Int] = [0,0,0,0,0,0,0,0]
    @AppStorage("Inside40Them") var csvInside40Them = ""
    @State private var  csvInside40ThemArray: [Int] = [0,0,0,0]
    //Inside 40 Difference
    @AppStorage("Inside40Difference") var csvInside40Difference = ""
    @State private var  csvInside40DiffArray: [Int] = [0,0,0,0]
    
    
    //Score
    @AppStorage("Score") var Score = ""
    @State private var ScoreArray: [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,]
    //HC Scores
    @AppStorage("csvHCGoals") var csvHCGoals = ""
    @State private var csvHCGoalArray: [Int] = [0,0,0,0]
    @AppStorage("csvHCPoints") var csvHCPoints = ""
    @State private var csvHCPointsArray: [Int] = [0,0,0,0]
    //Op Scores
    @AppStorage("csvOpGoals") var csvOpGoals = ""
    @State private var csvOpGoalArray: [Int] = [0,0,0,0]
    @AppStorage("csvHCPoints") var csvOpPoints = ""
    @State private var csvOpPointsArray: [Int] = [0,0,0,0]
    // Score Difference
    @AppStorage("csvScoreDifference") var csvScoreDifference = ""
    @State private var csvScoreDifferenceArray: [Int] = [0,0,0,0]
  
  
    
    var body: some View {
        if matchDetails.matchArray.count != 0  {
           
            HStack {
                Spacer()
                Text(matchDetails.matchArray[0].competition + " " + matchDetails.matchArray[0].level)
                    .font(.title2)
                Text("\(matchDetails.matchArray[0].home) v ")
                    .font(.title2)
                Text(matchDetails.matchArray[0].opponent)
                    .font(.title2)
                Spacer()
                Text("Round")
                    .font(.title2)
                Text("\(matchDetails.matchArray[0].round),")
                    .font(.title2)
                Text("\(matchDetails.matchArray[0].gameDate, format: .dateTime.year())")
                    .font(.title2)
                Spacer()
            }
            .foregroundColor(CustomMag.HC_Mag)
            .padding(.top)
            
            
        } else {
            Text("No game details")
        }
        
        ScrollView(.horizontal) {
            ScrollView(.vertical) {
                Group{
                    Headers
                    QSClearanceView()
                    QSContestedView()
                    QSTacklesView()
                    QSMarksView()
                    QSInside40View()
                    Divider()
                        .frame(maxWidth: .infinity, minHeight: 2)
                        .overlay(CustomMag.HC_Mag)
                    QSScoreView()
                }
                
                .sheet(isPresented: $showPDFSheet) {
                    PDFURL = nil
                } content: {
                    if let PDFUrl = PDFURL {
                        ShareSheet(urls: [PDFUrl])
                    }
                }
                
                .navigationTitle("Quarter Summary")
                .navigationBarItems(trailing:
                                        HStack {
                    ShareLink(item:generateCSV()) {
                        VStack {
                            Label("csv export", systemImage: "list.bullet.rectangle.portrait.fill")
                                .labelStyle(.iconOnly)
                            Text("csv export")
                        }
                    }
                    
//
                    Button() {
                        dismiss()
                    } label: {
                        VStack {
                            Image(systemName: "multiply.circle")
                            Text("Cancel")
                        }
                    }
                }
                    .foregroundColor(CustomMag.HC_Mag)
                )
                .onAppear { updateContestedArrays()
                    updateClearanceArrays()
                    updateTacklesArrays()
                    updateMarksArrays()
                    updateInside40Arrays()
                    updateScoreArray()
                    updateGoalkicker()
                    
                }
            }
            
        }
        
    }

    func updateGoalkicker() {
        if scoreViewModel.scoreArray.count == 0 {
           // Text("no goakkickers")
        } else {
            goalFreqArray = Dictionary( scoreViewModel.scoreArray.filter({ $0.scoreEvent == "G" && $0.team == "HC"}).map { ($0.goalScorer, 1) }, uniquingKeysWith: +)
            let sortGoalList =  goalFreqArray.sorted(by:  { $1.value < $0.value } )
            if goalFreqArray.count !=  0 {
                let count  =  0...sortGoalList.count - 1
                
                csvGKList = ""
                for number in count {
                    if  csvGKList == "" {
                        csvGKList = "Goalkickers,\( Array(sortGoalList)[number].key), (\( Array(sortGoalList)[number].value)) \n"
                    } else {
                        
                        csvGKList += ",\( Array(sortGoalList)[number].key), (\( Array(sortGoalList)[number].value)) \n"
                        print("\( Array(sortGoalList)[number].key) (\( Array(sortGoalList)[number].value))")
                    }
                }
            }
        }
        
    }
    
}
           
    
        struct QuarterSummaryView_Previews: PreviewProvider {
            static var previews: some View {
                QuarterSummaryView(matchDetails: MatchViewModel())
            }
        }
    
extension QuarterSummaryView {
    
    //csv export
        func generateCSV() -> URL {
            var fileURL: URL!
    
            // heading of CSV file.
            // game details
    
    
            let csvgameDetails = matchDetails.matchArray.count == 0 ? " no details" : "\(matchDetails.matchArray[0].opponent)\n At \(matchDetails.matchArray[0].venue)\n R\(matchDetails.matchArray[0].round) \(matchDetails.matchArray[0].gameDate.formatted(.dateTime.year()))\n ,,,,, \n"
    
            //quarter header
            let heading = "Quarter, First, Second, Third, Fourth, Total\n"
    
            // blank row
            let blankRow = ",,,,, \n"
    
            //  Centre Clearance
            let centreClearanceComma = "Centre Clearance" + "," + String(csvCentreCearanceArray[0]) + "," + String(csvCentreCearanceArray[1])  + "," +  String(csvCentreCearanceArray[2])  + "," +  String(csvCentreCearanceArray[3]) +  "," + String(csvCentreCearanceArray[0..<4].reduce(0,+)) + "\n"
    
            let otherClearanceComma = "Other Clearance" + "," + String(csvOtherCearanceArray[0]) + "," + String(csvOtherCearanceArray[1])  + "," +  String(csvOtherCearanceArray[2])  + "," +  String(csvOtherCearanceArray[3]) +  "," + String(csvOtherCearanceArray[0..<4].reduce(0,+)) + "\n"
    
            // table row contested ball
            let contestedComma = "Contested Ball" + "," + String(csvContestedArray[0]) + "," + String(csvContestedArray[1])  + "," +  String(csvContestedArray[2])  + "," +  String(csvContestedArray[3]) +  "," + String(csvContestedArray[0..<4].reduce(0,+)) + "\n"
            // tackles
            let tacklesTotal = "Total Tackles" + "," + String(csvTotalTacklesArray[0]) + "," + String(csvTotalTacklesArray[1])  + "," +  String(csvTotalTacklesArray[2])  + "," +  String(csvTotalTacklesArray[3]) +  "," + String(csvTotalTacklesArray[0..<4].reduce(0,+)) + "\n"
            let tacklesInside40 = "Inside 40 Tackles" + "," + String(csvInside40TacklesArray[0]) + "," + String(csvInside40TacklesArray[1])  + "," +  String(csvInside40TacklesArray[2])  + "," +  String(csvInside40TacklesArray[3]) +  "," + String(csvInside40TacklesArray[0..<4].reduce(0,+)) + "\n"
    
            // total marks
            let totalMarks = "Total Marks" + "," + String(totalMarksArray[0]) + "," + String(totalMarksArray[1]) + "," + String(totalMarksArray[2]) + "," + String(totalMarksArray[3]) + "," + String(totalMarksArray[0..<4].reduce(0,+))  + "\n"
    
            // inside 40s
            let  inside40Us = "Inside 40 Us" + "," + String(csvInside40UsArray[0]) + "," + String(csvInside40UsArray[1])  + "," +  String(csvInside40UsArray[2])  + "," +  String(csvInside40UsArray[3]) +  "," + String(csvInside40UsArray[0..<4].reduce(0,+)) + "\n"
    
            let  inside40Them = "Inside 40 Them" + "," + String(csvInside40ThemArray[0]) + "," + String(csvInside40ThemArray[1])  + "," +  String(csvInside40ThemArray[2])  + "," +  String(csvInside40ThemArray[3]) +  "," + String(csvInside40ThemArray[0..<4].reduce(0,+)) + "\n"
    
            let  inside40Diff = "Inside 40 Difference" + "," + String( csvInside40DiffArray[0]) + "," + String( csvInside40DiffArray[1])  + "," +  String( csvInside40DiffArray[2])  + "," +  String( csvInside40DiffArray[3]) +  "," + String( csvInside40DiffArray[0..<4].reduce(0,+)) + "\n"
    
            // scoring details
            let HCQ1 = 6 * csvHCGoalArray[0] + csvHCPointsArray[0]
            let HCQ2 = 6 * csvHCGoalArray[1] + csvHCPointsArray[1]
            let HCQ3 = 6 * csvHCGoalArray[2] + csvHCPointsArray[2]
            let HCQ4 = 6 * csvHCGoalArray[3] + csvHCPointsArray[3]
            let HCTot = 6 * csvHCGoalArray[0..<4].reduce(0,+) + csvHCPointsArray[0..<4].reduce(0,+)
            let HCScoreTotal = "Points For" + "," + "\(HCQ1)" + "," + "\(HCQ2)" + "," + "\(HCQ3)" + "," + "\(HCQ4)" + "," + "\(HCTot)"  + "\n"
    
            let OpQ1 = 6 * csvOpGoalArray[0] + csvOpPointsArray[0]
            let OpQ2 = 6 * csvOpGoalArray[1] + csvOpPointsArray[1]
            let OpQ3 = 6 * csvOpGoalArray[2] + csvOpPointsArray[2]
            let OpQ4 = 6 * csvOpGoalArray[3] + csvOpPointsArray[3]
            let OpTot = 6 * csvOpGoalArray[0..<4].reduce(0,+) + csvOpPointsArray[0..<4].reduce(0,+)
            let OpScoreTotal = "Points Against" + "," + "\(OpQ1)" + "," + "\(OpQ2)" + "," + "\(OpQ3)" + "," + "\(OpQ4)" + "," + "\(OpTot)"  + "\n"
    
            let  Difference = "Difference" + "," + "\(HCQ1 - OpQ1)" + "," + "\(HCQ2 - OpQ2)"  + "," +  "\(HCQ3 - OpQ3)"  + "," + "\(HCQ4 - OpQ4)" +  "," + "\(HCTot-OpTot)" + "\n"
    
            let  Qwin = "Quarter win" + "," + "\(csvScoreDifferenceArray[0] == 0 ? "-" : csvScoreDifferenceArray[0] > 0 ? "✓" : "✘" ),"
            + "\(csvScoreDifferenceArray[1] == 0 ? "-" : csvScoreDifferenceArray[1] > 0 ? "✓" : "✘" ),"
            + "\(csvScoreDifferenceArray[2] == 0 ? "-" : csvScoreDifferenceArray[2] > 0 ? "✓" : "✘" ),"
            + "\(csvScoreDifferenceArray[3] == 0 ? "-" : csvScoreDifferenceArray[3] > 0 ? "✓" : "✘" ),"
            + "\(csvScoreDifferenceArray[0..<4].reduce(0,+) == 0 ? "-" : csvScoreDifferenceArray[0..<4].reduce(0,+) > 0 ? "✓" : "✘" )" + "\n"
    
            // rows to string data
            let stringData = csvgameDetails + heading + blankRow + centreClearanceComma +  otherClearanceComma + contestedComma + tacklesTotal + tacklesInside40  +  totalMarks + inside40Us + inside40Them + inside40Diff + HCScoreTotal +  OpScoreTotal + Difference + Qwin + blankRow  + csvGKList
    
            do {
    
                let path = try FileManager.default.url(for: .documentDirectory,
                                                       in: .allDomainsMask,
                                                       appropriateFor: nil,
                                                       create: false)
    
                fileURL = path.appendingPathComponent("QuarterSummary.csv")
    
                // append string data to file
                try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
                print(fileURL!)
    
            } catch {
                print("error generating csv file")
            }
            return fileURL
        }
    
             private func updateContestedArrays() {
                 // Contested
                 if contested == "" {
                     contested = "0,0,0,0,0,0,0,0"
                     contestedArray  = [0,0,0,0,0,0,0,0]
                 } else {
                     contestedArray = contested.components(separatedBy: ",").map { Int($0) ?? 0 }
                 }
                 csvContestedArray = [contestedArray[0] - contestedArray[4],contestedArray[1] - contestedArray[5], contestedArray[2] - contestedArray[6], contestedArray[3] - contestedArray[7]]
             }
             // update Clearances
             func updateClearanceArrays() {
                 
                 if clearance == "" {
                     clearance = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
                     clearanceArray  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
                 } else {
                     clearanceArray = clearance.components(separatedBy: ",").map { Int($0) ?? 0 }
                 }
                 csvCentreCearanceArray = [clearanceArray[0] - clearanceArray[8],clearanceArray[1] - clearanceArray[9], clearanceArray[2] - clearanceArray[10], clearanceArray[3] - clearanceArray[11]]
                 csvOtherCearanceArray = [clearanceArray[4] - clearanceArray[12],clearanceArray[5] - clearanceArray[13], clearanceArray[6] - clearanceArray[14], clearanceArray[7] - clearanceArray[15]]
                 
             }
             // update tackles
             private func updateTacklesArrays() {
                 // Tackles
                 if tackles == "" {
                     tackles = "0,0,0,0,0,0,0,0,0,0,0,0"
                     tacklesArray = [0,0,0,0,0,0,0,0,0,0,0,0]
                 } else {
                     
                     tacklesArray = tackles.components(separatedBy: ",").map { Int($0) ?? 0 }
                 }
                 csvTotalTacklesArray = [tacklesArray[0] + tacklesArray[4] + tacklesArray[8],tacklesArray[1] + tacklesArray[5] + tacklesArray[9], tacklesArray[2] + tacklesArray[6] + tacklesArray[10], tacklesArray[3] + tacklesArray[7] + tacklesArray[11]]
                 csvInside40TacklesArray = [tacklesArray[0] ,tacklesArray[1] , tacklesArray[2] , tacklesArray[3] ]
             }
             
             // Marks
             private func updateMarksArrays() {
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
                 totalMarksArray = [(hcMarksArray[0] + hcMarksArray[4] + hcMarksArray[8] + hcMarksArray[12] + hcMarksArray[16] + hcMarksArray[20]) - (opMarksArray[0] + opMarksArray[4] + opMarksArray[8] + opMarksArray[12] + opMarksArray[16] + opMarksArray[20]),
                                    (hcMarksArray[1] + hcMarksArray[5] + hcMarksArray[9] + hcMarksArray[13] + hcMarksArray[17] + hcMarksArray[21]) - (opMarksArray[1] + opMarksArray[5] + opMarksArray[9] + opMarksArray[13] + opMarksArray[17] + opMarksArray[21]), (hcMarksArray[2] + hcMarksArray[6] + hcMarksArray[10] + hcMarksArray[14] + hcMarksArray[18] + hcMarksArray[22]) - (opMarksArray[2] + opMarksArray[6] + opMarksArray[10] + opMarksArray[14] + opMarksArray[18] + opMarksArray[22]),(hcMarksArray[3] + hcMarksArray[7] + hcMarksArray[11] + hcMarksArray[15] + hcMarksArray[19] + hcMarksArray[23]) - (opMarksArray[3] + opMarksArray[7] + opMarksArray[11] + opMarksArray[15] + opMarksArray[19] + opMarksArray[23])]
                 
             }
             //Inside 40
             private func updateInside40Arrays() {
                 // HcInside 40s
                 if hcInside40 == "" {
                     hcInside40 = "0,0,0,0,0,0,0,0"
                     hcInside40Array = [0,0,0,0,0,0,0,0]
                 } else {
                     
                     hcInside40Array = hcInside40.components(separatedBy: ",").map { Int($0) ?? 0 }
                 }
                 csvInside40UsArray = [hcInside40Array[0] + hcInside40Array[4],hcInside40Array[1] + hcInside40Array[5] , hcInside40Array[2] + hcInside40Array[6] , hcInside40Array[3] + hcInside40Array[7] ]
                 csvInside40UsShallowArray = [ hcInside40Array[4] , hcInside40Array[5] ,  hcInside40Array[6] ,  hcInside40Array[7] ]
                 
                 
                 // OpInside 40s
                 if opInside40 == "" {
                     opInside40 = "0,0,0,0,0,0,0,0"
                     opInside40Array = [0,0,0,0,0,0,0,0]
                 } else {
                     opInside40Array = opInside40.components(separatedBy: ",").map { Int($0) ?? 0 }
                 }
                 csvInside40ThemArray = [opInside40Array[0] + opInside40Array[4],opInside40Array[1] + opInside40Array[5], opInside40Array[2] + opInside40Array[6], opInside40Array[3] + opInside40Array[7]]
                 
                 csvInside40DiffArray = [(hcInside40Array[0] + hcInside40Array[4]) - (opInside40Array[0] + opInside40Array[4]),
                                         (hcInside40Array[1] + hcInside40Array[5]) - (opInside40Array[1] + opInside40Array[5]) ,
                                         (hcInside40Array[2] + hcInside40Array[6]) - (opInside40Array[2] + opInside40Array[6]) ,
                                         (hcInside40Array[3] + hcInside40Array[7]) - (opInside40Array[3] + opInside40Array[7])  ]
                 
                 
             }
             //Scores
             func updateScoreArray() {
                 if Score == "" {
                     Score = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
                     ScoreArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
                     print(" not updated  \(ScoreArray)")
                 } else {
                     ScoreArray = Score.components(separatedBy: ",").map { Int($0) ?? 0  }
                     print("update \(ScoreArray)")
                 }
                 csvHCGoalArray = [ScoreArray[0], ScoreArray[1], ScoreArray[2], ScoreArray[3]]
                 csvHCPointsArray = [ScoreArray[4], ScoreArray[5], ScoreArray[6], ScoreArray[7]]
                 csvOpGoalArray = [ScoreArray[8], ScoreArray[9], ScoreArray[10], ScoreArray[11]]
                 csvOpPointsArray = [ScoreArray[12], ScoreArray[13], ScoreArray[14], ScoreArray[15]]
                 csvScoreDifferenceArray = [  6 * ScoreArray[0] + ScoreArray[4] - 6 * ScoreArray[8] - ScoreArray[12],
                                              6 * ScoreArray[1] + ScoreArray[5] - 6 * ScoreArray[9] - ScoreArray[13],
                                              6 * ScoreArray[2] + ScoreArray[6] - 6 * ScoreArray[10] - ScoreArray[14],
                                              6 * ScoreArray[3] + ScoreArray[7] - 6 * ScoreArray[11] - ScoreArray[15],
                 ]
                 
                 
                 
             }
         
    
    private var Headers: some View {
    HStack {
        Group {
            Text("Quarter")
                .padding()
                .frame(width: 260, height: 45)
                .border(.gray)
                .foregroundColor(CustomMag.HC_Mag)
                .padding(.horizontal)
            // First Quarter
            Text("1st")
                .padding()
                .frame(width: 70, height: 45)
                .border(.gray)
                .foregroundColor(CustomMag.HC_Mag)
            // Second Quarter
            Text("2nd")
                .padding()
                .frame(width: 70, height: 45)
                .border(.gray)
                .foregroundColor(CustomMag.HC_Mag)
                .background(.gray.opacity(0.1))
            // Third Quarter
            Text("3rd")
                .padding()
                .frame(width: 70, height: 45)
                .border(.gray)
                .foregroundColor(CustomMag.HC_Mag)
            // Fourth Quarter
                Text("4th")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .foregroundColor(CustomMag.HC_Mag)
                    .background(.gray.opacity(0.1))
            Text("Total")
                    .padding()
                    .frame(width: 100, height: 45)
                    .foregroundColor(CustomMag.HC_Mag)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                     .padding(.horizontal)
        }
        .font(.title3)

        }
    }
}
// MARK: Share sheet
struct ShareSheet: UIViewControllerRepresentable {
    
    var urls: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        return controller
        
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
   
}
