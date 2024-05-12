//
//  ScoreTypeView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 17/3/2024.
//

import SwiftUI

struct ScoreTypeView: View {
    
    //Custom Colours
    struct CustomGold {static let HC_Gold = Color("HC_Gold")}
    struct CustomMag {static let HC_Mag = Color("HC_Magenta") }
    
    @StateObject var matchViewModel = MatchViewModel()
    @StateObject var scoreViewModel = ScoreViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    // Score Position Array
  // quarter view  for body data
    @State private var TypeMatrixFrequencyArray: [Int : Int] = [:]
    //quarter view row total
    @State private var TotalArray: [Int : Int] = [:]
    //Origin view
    @State private var OriginMatrixFrequencyArray: [Int : Int] = [:]
    // Game totals
    @State private var  TotalGame: [Int : Int] = [:]
    @State private var  TotalScore: [Int : Int] = [:]
    
    
    @State private var Gtype = "Cen"
    @State private var Qquarter = 1
    @State private var QAdder = 0
    @State private var GHeader = "Score From Centre Clearances"
    @State private var GAdder = 0
    @State private var QHeader = "First Quarter"
    @State private var  showOrigin = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Toggle(showOrigin ?  "To Quarter" : "To Score Origin" , isOn: $showOrigin.animation())
                    .foregroundColor(CustomMag.HC_Mag)
                    .toggleStyle(SwitchToggleStyle(tint: CustomGold.HC_Gold))
                    .padding(.horizontal)
                
                
                Spacer()
                // Origins within a quarter
                
                if showOrigin {
                    Group {
                        Picker("Quarter", selection: $Qquarter) {
                            Text("1")
                                .tag(1)
                            Text("2")
                                .tag(2)
                            Text("3")
                                .tag(3)
                            Text("4")
                                .tag(4)
                            Text("Game")
                                .tag(5)
                            
                        }
                        .onChange(of: Qquarter, perform: { (value) in
                            Updatequarter()
                        })
                       
                        .pickerStyle(.segmented)
                        .background(CustomMag.HC_Mag.opacity(0.3))
                        .padding()
                        Text(QHeader)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title2)
                        if Qquarter == 5 {
                            scoreTypeTotal
                        } else {
                            scoreTypeQuarter
                        }
                       
                    }
                } else {
                    // Origins by type
                    Group {
                        Picker("Type", selection: $Gtype) {
                            Text("Centre")
                                .tag("Cen")
                            Text("Stoppage")
                                .tag("Sto")
                            Text("TurnOver")
                                .tag("Tur")
                            Text("Kickin")
                                .tag("Kic")
                            Text("General")
                                .tag("Gen")
                            
                        }
                        .onChange(of: Gtype, perform: { (value) in
                            UpdateHeader()
                        })
                        .pickerStyle(.segmented)
                        .background(CustomMag.HC_Mag.opacity(0.3))
                        .padding()
                        
                        Text(GHeader)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title2)
                        scoreType
                    }
                }
                Spacer()
                Spacer()
                Spacer()
                    .onAppear() {
                        updateTypeArray()
                        print(TypeMatrixFrequencyArray)
                        print("Tot \(TotalArray)")
                        print("Game Tot \(TotalGame)")
                        
                    }
                    .navigationBarTitle("Score Origin")
                    .navigationBarItems (
                        leading:
                            Button {
                                dismiss()
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.left")
                                    Text("Score Input")
                                    
                                }
                            }
                    )
            }
        }
    }
    func Updatequarter() {
        QAdder = 0
        switch Qquarter {
        case 1:
            QAdder += 0
            QHeader = "First Quarter"
            
        case 2:
            QAdder += 64
            QHeader = "Second Quarter"
            
        case 3:
            QAdder += 128
            QHeader = "Third Quarter"
            
        case 4:
            QAdder += 192
            QHeader = "Fourth Quarter"
            
        default:
            QAdder += 200
            QHeader = "Game Totals"
            
            
        }
    }
    func UpdateHeader() {
        GAdder = 0
        switch Gtype {
        case "Cen":
           GHeader = "Score From A Centre Bounce"
            GAdder += 0
        case "Sto":
           GHeader = "Score From A Stoppage"
            GAdder += 1
        case "Tur":
           GHeader = "Score From A TurnOver"
            GAdder += 2
        case "Kic":
           GHeader = "Score From A Kick In"
            GAdder += 3
        case "Gen":
           GHeader = "General Play"
            GAdder += 4
        default:
            GHeader = "no selection"
            GAdder += 4
        }
    }
    
    
    func updateTypeArray() {
     
       // quarter view body data
     TypeMatrixFrequencyArray = Dictionary( scoreViewModel.scoreArray.map { ($0.typeNummer & 255, 1) }, uniquingKeysWith: +)
        // Game totals
    TotalArray = Dictionary( scoreViewModel.scoreArray.map { (($0.typeNummer & 63), 1) }, uniquingKeysWith: +)
     //Quarter totals
    TotalGame = Dictionary( scoreViewModel.scoreArray.map { (($0.typeNummer & 248), 1) }, uniquingKeysWith: +)
     // Game Scores
    TotalScore = Dictionary( scoreViewModel.scoreArray.map { (($0.typeNummer & 56), 1) }, uniquingKeysWith: +)
 }
    
}

#Preview {
    ScoreTypeView()
}

extension ScoreTypeView {
    // Table by Origin
    private var scoreType: some View {
        
        VStack {
            
            HStack {
           
            VStack{
                Text("Quarter")
                    .frame(width: 80, height: 40)
                Text("Q1")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
                
                Text("Q2")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
                
                Text("Q3")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
                
                Text("Q4")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
                
                Text("Game")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
            }
            // Haileybury scores
            VStack{
                if matchViewModel.matchArray.count == 0 {
                    Text("Home")
                        .frame(width: 200, height: 40)
                        .border(.black)
                } else {
                    Text(matchViewModel.matchArray[0].homeAbbr)
                        .frame(width: 200, height: 40)
                        .border(.black)
                }
                // 1st Quarter
                Text("\(TypeMatrixFrequencyArray[48 + GAdder]  ?? 0) - \(TypeMatrixFrequencyArray[40 + GAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[48 + GAdder]  ?? 0) + (TypeMatrixFrequencyArray[40 + GAdder]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                // 2nd Quarter
                Text("\(TypeMatrixFrequencyArray[112 + GAdder]  ?? 0) - \(TypeMatrixFrequencyArray[104 + GAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[112 + GAdder]  ?? 0) + (TypeMatrixFrequencyArray[104 + GAdder]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                // 3rd Quarter
                Text("\(TypeMatrixFrequencyArray[176 + GAdder]  ?? 0) - \(TypeMatrixFrequencyArray[168 + GAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[176 + GAdder]  ?? 0) + (TypeMatrixFrequencyArray[168 + GAdder]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                // 4th Quarter
                Text("\(TypeMatrixFrequencyArray[240 + GAdder]  ?? 0) - \(TypeMatrixFrequencyArray[232 + GAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[240 + GAdder]  ?? 0) + (TypeMatrixFrequencyArray[232 + GAdder]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                // Game Totals
                Text("\(TotalArray[48 + GAdder]  ?? 0) - \(TotalArray[40 + GAdder]  ?? 0) (\(6 * (TotalArray[48 + GAdder]  ?? 0) + (TotalArray[40 + GAdder]  ?? 0)))")
                 
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                    .background(.gray.opacity(0.2))
                
            }
            // Opposition scores
            VStack{
                if matchViewModel.matchArray.count == 0 {
                    Text("Away")
                        .frame(width: 200, height: 40)
                        .border(Color.gray)
                } else {
                    Text(matchViewModel.matchArray[0].oppAbbr)
                        .frame(width: 200, height: 40)
                        .border(Color.gray)
                }
                // 1st Quarter
                Text("\(TypeMatrixFrequencyArray[16 + GAdder]  ?? 0) - \(TypeMatrixFrequencyArray[8 + GAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[16 + GAdder]  ?? 0) + (TypeMatrixFrequencyArray[8 + GAdder]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(Color.gray)
                // 2nd Quarter
                Text("\(TypeMatrixFrequencyArray[80 + GAdder]  ?? 0) - \(TypeMatrixFrequencyArray[72 + GAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[80 + GAdder]  ?? 0) + (TypeMatrixFrequencyArray[72 + GAdder]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(Color.gray)
                // 3rd Quarter
                Text("\(TypeMatrixFrequencyArray[144 + GAdder]  ?? 0) - \(TypeMatrixFrequencyArray[136 + GAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[144 + GAdder]  ?? 0) + (TypeMatrixFrequencyArray[136 + GAdder]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(Color.gray)
                // 4th Quarter
                Text("\(TypeMatrixFrequencyArray[208 + GAdder]  ?? 0) - \(TypeMatrixFrequencyArray[200 + GAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[208 + GAdder]  ?? 0) + (TypeMatrixFrequencyArray[200 + GAdder]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(Color.gray)
                // Game Totals
                Text("\(TotalArray[16 + GAdder]  ?? 0) - \(TotalArray[8 + GAdder]  ?? 0) (\(6 * (TotalArray[16 + GAdder]  ?? 0) + (TotalArray[8 + GAdder]  ?? 0)))")
                 
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(Color.gray)
                    .background(.gray.opacity(0.2))
                
                }
            }
        }
    }
    // Table by Origin
    private var scoreTypeQuarter: some View {
        
        VStack {
            HStack {
           
            VStack{
                Text("Origin")
                    .frame(width: 80, height: 40)
                Text("Centre")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
                
                Text("Stoppage")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
                
                Text("TurnOver")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
                
                Text("Kick In")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
                Text("General")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
                Text("Total")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
            }
            // Haileybury scores
            VStack{
                if matchViewModel.matchArray.count == 0 {
                    Text("Home")
                        .frame(width: 200, height: 40)
                        .border(.black)
                } else {
                    Text(matchViewModel.matchArray[0].homeAbbr)
                        .frame(width: 200, height: 40)
                        .border(.black)
                }
              
                    // Centre
                    Text("\(TypeMatrixFrequencyArray[48 + QAdder]  ?? 0) - \(TypeMatrixFrequencyArray[40 + QAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[48 + QAdder]  ?? 0) + (TypeMatrixFrequencyArray[40 + QAdder]  ?? 0)))")
                        .frame(width: 200, height: 40)
                        .padding(.horizontal)
                        .border(.black)
                    // Stoppage
                    Text("\(TypeMatrixFrequencyArray[49 + QAdder]  ?? 0) - \(TypeMatrixFrequencyArray[41 + QAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[49 + QAdder]  ?? 0) + (TypeMatrixFrequencyArray[41 + QAdder]  ?? 0)))")
                        .frame(width: 200, height: 40)
                        .padding(.horizontal)
                        .border(.black)
                    // Turnover
                    Text("\(TypeMatrixFrequencyArray[50 + QAdder]  ?? 0) - \(TypeMatrixFrequencyArray[42 + QAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[50 + QAdder]  ?? 0) + (TypeMatrixFrequencyArray[42 + QAdder]  ?? 0)))")
                        .frame(width: 200, height: 40)
                        .padding(.horizontal)
                        .border(.black)
                    // Kick in
                    Text("\(TypeMatrixFrequencyArray[51 + QAdder]  ?? 0) - \(TypeMatrixFrequencyArray[43 + QAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[51 + QAdder]  ?? 0) + (TypeMatrixFrequencyArray[43 + QAdder]  ?? 0)))")
                        .frame(width: 200, height: 40)
                        .padding(.horizontal)
                        .border(.black)
                    // General
                    Text("\(TypeMatrixFrequencyArray[52 + QAdder]  ?? 0) - \(TypeMatrixFrequencyArray[44 + QAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[52 + QAdder]  ?? 0) + (TypeMatrixFrequencyArray[44 + QAdder]  ?? 0)))")
                        .frame(width: 200, height: 40)
                        .padding(.horizontal)
                        .border(.black)
                    // Game Totals
                    Text("\(TotalGame[48 + QAdder]  ?? 0) - \(TotalGame[40 + QAdder]  ?? 0) (\(6 * (TotalGame[48 + QAdder]  ?? 0) + (TotalGame[40 + QAdder]  ?? 0)))")
                        .frame(width: 200, height: 40)
                        .padding(.horizontal)
                        .border(.black)
                        .background(.gray.opacity(0.2))
             
                 
            }
            // Opposition scores
            VStack{
                if matchViewModel.matchArray.count == 0 {
                    Text("Away")
                        .frame(width: 200, height: 40)
                        .border(Color.gray)
                } else {
                    Text(matchViewModel.matchArray[0].oppAbbr)
                        .frame(width: 200, height: 40)
                        .border(Color.gray)
                }
                // Centre
                Text("\(TypeMatrixFrequencyArray[16 + QAdder]  ?? 0) - \(TypeMatrixFrequencyArray[8 + QAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[16 + QAdder]  ?? 0) + (TypeMatrixFrequencyArray[8 + QAdder]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(Color.gray)
                // Stoppage
                Text("\(TypeMatrixFrequencyArray[17 + QAdder]  ?? 0) - \(TypeMatrixFrequencyArray[9 + QAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[17 + QAdder]  ?? 0) + (TypeMatrixFrequencyArray[9 + QAdder]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(Color.gray)
                // TurnOver
                Text("\(TypeMatrixFrequencyArray[18 + QAdder]  ?? 0) - \(TypeMatrixFrequencyArray[10 + QAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[18 + QAdder]  ?? 0) + (TypeMatrixFrequencyArray[10 + QAdder]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(Color.gray)
                // Kick in
                Text("\(TypeMatrixFrequencyArray[19 + QAdder]  ?? 0) - \(TypeMatrixFrequencyArray[11 + QAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[19 + QAdder]  ?? 0) + (TypeMatrixFrequencyArray[11 + QAdder]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(Color.gray)
                // General
                Text("\(TypeMatrixFrequencyArray[20 + QAdder]  ?? 0) - \(TypeMatrixFrequencyArray[12 + QAdder]  ?? 0) (\(6 * (TypeMatrixFrequencyArray[20 + QAdder]  ?? 0) + (TypeMatrixFrequencyArray[12 + QAdder]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(Color.gray)
                // Game Totals
                Text("\(TotalGame[16 + QAdder]  ?? 0) - \(TotalGame[8 + QAdder]  ?? 0) (\(6 * (TotalGame[16 + QAdder]  ?? 0) + (TotalGame[8 + QAdder]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(Color.gray)
                    .background(.gray.opacity(0.2))
                
                }
            }
        }
    }
    private var scoreTypeTotal: some View {
        
        VStack {
            
            HStack {
           
            VStack{
                Text("Origin")
                    .frame(width: 80, height: 40)
                Text("Centre")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
                
                Text("Stoppage")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
                
                Text("TurnOver")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
                
                Text("Kick In")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
                Text("General")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
                Text("Total")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(Color.gray)
            }
            // Haileybury scores
            VStack{
                if matchViewModel.matchArray.count == 0 {
                    Text("Home")
                        .frame(width: 200, height: 40)
                        .border(.black)
                } else {
                    Text(matchViewModel.matchArray[0].homeAbbr)
                        .frame(width: 200, height: 40)
                        .border(.black)
                }
                // Centre
                Text("\(TotalArray[48]  ?? 0) - \(TotalArray[40]  ?? 0) (\(6 * (TotalArray[48]  ?? 0) + (TotalArray[40]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                // Stoppage
                Text("\(TotalArray[49]  ?? 0) - \(TotalArray[41]  ?? 0) (\(6 * (TotalArray[49]  ?? 0) + (TotalArray[41]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                // TurnOver
                Text("\(TotalArray[50]  ?? 0) - \(TotalArray[42]  ?? 0) (\(6 * (TotalArray[50]  ?? 0) + (TotalArray[42]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                // KIck In
                Text("\(TotalArray[51]  ?? 0) - \(TotalArray[43]  ?? 0) (\(6 * (TotalArray[51]  ?? 0) + (TotalArray[43]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                // General
                Text("\(TotalArray[52]  ?? 0) - \(TotalArray[44]  ?? 0) (\(6 * (TotalArray[52]  ?? 0) + (TotalArray[44]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                // Game Totals
                Text("\(TotalScore[48]  ?? 0) - \(TotalScore[40]  ?? 0) (\(6 * (TotalScore[48]  ?? 0) + (TotalScore[40]  ?? 0)))")
                 
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                    .background(.gray.opacity(0.2))
                
            }
            // Opposition scores
            VStack{
                if matchViewModel.matchArray.count == 0 {
                    Text("Away")
                        .frame(width: 200, height: 40)
                        .border(Color.gray)
                } else {
                    Text(matchViewModel.matchArray[0].oppAbbr)
                        .frame(width: 200, height: 40)
                        .border(Color.gray)
                }
                // Centre
                Text("\(TotalArray[16]  ?? 0) - \(TotalArray[8]  ?? 0) (\(6 * (TotalArray[16]  ?? 0) + (TotalArray[8]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                // Stoppage
                Text("\(TotalArray[17]  ?? 0) - \(TotalArray[9]  ?? 0) (\(6 * (TotalArray[49]  ?? 0) + (TotalArray[9]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                // TurnOver
                Text("\(TotalArray[18]  ?? 0) - \(TotalArray[10]  ?? 0) (\(6 * (TotalArray[18]  ?? 0) + (TotalArray[10]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                // KIck In
                Text("\(TotalArray[19]  ?? 0) - \(TotalArray[11]  ?? 0) (\(6 * (TotalArray[19]  ?? 0) + (TotalArray[11]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                // General
                Text("\(TotalArray[20]  ?? 0) - \(TotalArray[12]  ?? 0) (\(6 * (TotalArray[20]  ?? 0) + (TotalArray[12]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                // Game Totals
                Text("\(TotalScore[16]  ?? 0) - \(TotalScore[8]  ?? 0) (\(6 * (TotalScore[16]  ?? 0) + (TotalScore[8]  ?? 0)))")
                    .frame(width: 200, height: 40)
                    .padding(.horizontal)
                    .border(.black)
                    .background(.gray.opacity(0.2))
                
                }
            }
        }
    }
    
}
        
