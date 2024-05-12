//
//  ScoreView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 4/9/2023.
//

import SwiftUI

struct ScoreView: View {
    @StateObject var matchViewModel = MatchViewModel()
    @StateObject var scoreViewModel = ScoreViewModel()
    @StateObject var playerViewModel = PlayerViewModel()

    // scoreMatrix
    @State private var scoreNummerArray: [Int : Int] = [:]
    @State private var scoreTotalNummerArray: [Int : Int] = [:]
   
    //Custom Colours
    struct CustomGold {static let HC_Gold = Color("HC_Gold")}
    struct CustomMag {static let HC_Mag = Color("HC_Magenta") }
    
    //add Subtract bool
    @State private var isLastLine = false
    @State private var addValue = 1
    @State private var hcwormAdd = 0
    @State private var opwormAdd = 0
    
    // alert inputs
    @State var showNameAlert: Bool = false
    @State var showTypeAlert: Bool = false
    
    //Show Score Array
    @State var showScoreArray = false
    @State var showScoreType = false
    @Environment(\.dismiss) private var dismiss
   
    
    @State private var Team = true
    @State private var ScoreType = "B"
    @State private var ScoreInt = 0
    @State private var launch = "3"
    @State private var scoreSwap = 1
    @State private var goalName = ""
    @State private var scoreOrigin = "Gen"
    @State private var showEditView = false
    @State private var HCWorm = 0
    @State private var OpWorm = 0
    @State private var showResetAlert = false
    @State private var showScoreTimeline = true
    @State private var showScoreTable = true
    @State private var showScoreForm = true
    @State private var goalStringArray: [String] = []
    @State private var goalFreqArray: [String : Int] = [:]
    @State private var launchMatrixString = ""
    @State private var nummer: Int = 0
    @State private var typenummer: Int = 0
    @State private var nummerArray: [Int] = []
    
    
    let columns = [ GridItem(.flexible(minimum: 200)) ]
    
    @Binding var quarterInt: Int
   
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Toggle(showScoreForm ? "Score Input " : "Show Score Input", isOn: $showScoreForm.animation())
                        .foregroundColor(CustomMag.HC_Mag)
                        .toggleStyle(SwitchToggleStyle(tint: CustomGold.HC_Gold))
                        .padding(.horizontal)
                    // MARK: Enter score details
                    if !showScoreForm {
                    } else { scoreform
                    }
                }
                .navigationTitle("Score Input")
                .navigationBarItems (
                    leading:
                        
                        Button {
                            dismiss()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Game Input")
                                
                            }
                        }
                    
                    ,
                    trailing:
                        HStack {
                           
                            //Button to showing ScoreArray
                            Button {
                                showScoreArray.toggle()
                            } label: {
                                VStack {
                                    Image(systemName: "tablecells.fill")
                                    Text("Matrix")
                                }
                                
                                .foregroundColor(CustomMag.HC_Mag)
                            }
                            //Button to showing ScoreType
                            Button {
                                showScoreType.toggle()
                            } label: {
                                VStack {
                                    Image(systemName: "keyboard.fill")
                                    Text("Type")
                                }
                                
                                .foregroundColor(CustomMag.HC_Mag)
                            }
                            // remove last line
                            Button {
                                isLastLine = true
                            } label: {
                                VStack {
                                    VStack {
                                        Image(systemName:  "delete.left.fill")
                                        Text("undo")
                                    }
                                }
                                .foregroundColor(CustomMag.HC_Mag)
                                
                            }
                            Button() {
                                showResetAlert = true
                            } label: {
                                VStack {
                                    VStack {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                        Text("Reset")
                                    }
                                }
                                
                                .foregroundColor(CustomMag.HC_Mag)
                            }
                            
                        }
                )
                .alert("A goalkicker is required", isPresented: $showNameAlert) {
                    Button("OK", role: .cancel) { }
                }
                
                .alert("A goal type is required", isPresented:  $showTypeAlert) {
                    Button("OK", role: .cancel) { }
                }
                
                .alert(isPresented: $showResetAlert) {
                    Alert(
                        title: Text("If you proceed all goal details will reset"),
                        message: Text(" "),
                        primaryButton: .cancel(
                            Text("Cancel"),
                            action: {
                                showResetAlert = false
                            }
                        ),
                        secondaryButton: .destructive(
                            Text("Reset"),
                            action: {
                                resetScore()
                                showResetAlert = false
                            }
                        )
                    )
                }
                .alert(isPresented: $isLastLine) {
                    Alert(
                        title: Text("Delete last entry"),
                        message: Text(" "),
                        primaryButton: .cancel(
                            Text("Cancel"),
                            action: {
                                isLastLine = false
                            }
                        ),
                        secondaryButton: .destructive(
                            Text("Undo"),
                            action: {
                                removeLast()
                                updateScoreArray()
                                updateGoalkicker()
                                showResetAlert = false
                            }
                        )
                    )
                }
                // MARK: Scoreboard
                Toggle(showScoreTable ? "Scoreboard" : "Show Scoreboard", isOn: $showScoreTable.animation())
                    .foregroundColor(CustomMag.HC_Mag)
                    .toggleStyle(SwitchToggleStyle(tint: CustomGold.HC_Gold))
                    .padding(.horizontal)
                
                if !showScoreTable {
                }
                else {
                    Divider()
                        .frame(height: 2)
                        .overlay(.gray)
                    scoreboard
                }
                
                //MARK: List of scorers
                Toggle(showScoreTimeline ? "Score Timeline": "Show Score Timeline", isOn: $showScoreTimeline.animation())
                    .foregroundColor(CustomMag.HC_Mag)
                    .toggleStyle(SwitchToggleStyle(tint:CustomGold.HC_Gold))
                    .padding(.horizontal)
                
                if !showScoreTimeline {
                }
                else {
                    listOfScorers
                }
            }
            }
            .onDisappear() {
                updateScoreArray()
                updateGoalkicker()
             
            }
            .onAppear() {
                updateScoreArray()
                updateGoalkicker()
                
            }
            .sheet(isPresented: $showScoreArray) {
                ScoreArrayView()
            }
            .sheet(isPresented: $showScoreType) {
                ScoreTypeView()
            }
        }
    
}
    struct ScoreView_Previews: PreviewProvider {
        static var previews: some View {
            ScoreView(quarterInt: .constant(1))
        }
    }

extension ScoreView {
    // uses ScoreViewModel to update table
    func updateScoreArray() {
        
    scoreNummerArray = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 124), 1) }, uniquingKeysWith: +)
    scoreTotalNummerArray  = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 28), 1) }, uniquingKeysWith: +)
      
    }
   
    // MARK: Convert form data to nummer
    func scoreEventToNum() {
        nummer = 0
        typenummer = 0
        //quarter
        switch quarterInt {
        case 1:
            nummer += 0
            typenummer += 0
        case 2:
            nummer += 32
            typenummer += 64
        case 3:
            nummer += 64
            typenummer += 128
        case 4:
            nummer += 96
            typenummer += 192
        default:
            nummer += 96
            typenummer += 192
        }
        //team
        if Team {
           nummer += 16
            typenummer += 32
    } else {
        nummer += 0
        typenummer += 0
        }
      //  Score
        switch ScoreType {
            case "M":
            nummer += 0
            typenummer += 0
        case "B":
            nummer += 4
            typenummer += 8
        case "G":
            nummer += 8
            typenummer += 16
            default:
            nummer += 0
            typenummer += 0
        }
        
        switch launch {
            case "1":
            nummer += 0
            case "2":
            nummer += 1
            case "3":
            nummer += 2
            case "4":
            nummer += 3
            default:
            nummer += 0
        }
        switch scoreOrigin {
            case "Cen":
            typenummer += 0
            case "Sto":
            typenummer += 1
            case "Tur":
            typenummer += 2
            case "Kic":
            typenummer += 3
            case "Gen":
            typenummer += 4
            default:
            typenummer += 4
        }
    }
   
    

    func save() {
        scoreEventToNum() 
        switch (Team, ScoreType) {
        case (true, "G"):
            hcwormAdd = 6 * addValue
            opwormAdd = 0 * addValue
        case (true, "B"):
            hcwormAdd = 1 * addValue
            opwormAdd = 0 * addValue
        case (false, "G"):
            hcwormAdd = 0 * addValue
            opwormAdd = 6 * addValue
        case (false, "B"):
            hcwormAdd = 0 * addValue
            opwormAdd = 1 * addValue
        default:
            hcwormAdd = 0 * addValue
            opwormAdd = 0 * addValue
        }
        
        let hcWormOld = scoreViewModel.scoreArray.last?.HCWorm ?? 0
        let opWormOld = scoreViewModel.scoreArray.last?.OpWorm ?? 0
        let goalEvent = ScoreModel()
        goalEvent.quarter = String(quarterInt)
        
        goalEvent.team = Team ? "HC" : matchViewModel.matchArray.count == 0 ? "Op" : matchViewModel.matchArray[0].oppAbbr.trimmingCharacters(in: .whitespacesAndNewlines)
        goalEvent.scoreEvent = ScoreType
        goalEvent.scoreType = scoreOrigin
        goalEvent.HCWorm = hcWormOld +  hcwormAdd
        goalEvent.OpWorm = opWormOld + opwormAdd
        goalEvent.launchNummer = nummer
        goalEvent.typeNummer = typenummer
        if ScoreType == "G" {
            goalEvent.goalScorer = Team ? goalName : matchViewModel.matchArray.count == 0 ? "Op" : matchViewModel.matchArray[0].oppAbbr.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            goalEvent.goalScorer = Team ? "HC" : matchViewModel.matchArray.count == 0 ? "Op" : matchViewModel.matchArray[0].oppAbbr.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        scoreViewModel.addScoreDetails(goalEvent)
        updateScoreArray()
    }
    
    func delete(indexSet: IndexSet) {
        scoreViewModel.scoreArray.remove(atOffsets: indexSet)
        scoreViewModel.saveScore()
    }
    func removeLast() {
        scoreViewModel.scoreArray.removeLast()
        scoreViewModel.saveScore()
    }
    
    // MARK: ScoreCounter
       func scoreCounter() {
           switch (Team, ScoreType) {
           case (true, "G"):
               if  scoreOrigin.count < 3 {
                   showTypeAlert = true
                   
               } else if
                   goalName.count < 3 {
                   showNameAlert = true
               }
               
           default:
               showTypeAlert = false
               showNameAlert = false
           }
           if showTypeAlert == false && showNameAlert == false {
          
        
           switch (Team, ScoreType) {
           case (true, "G"):
               HCWorm = 6
           case (true, "B"):
               HCWorm = 1
           case (false, "G"):
               OpWorm = 6
           case (false, "B"):
               OpWorm = 1
           default:
               HCWorm = HCWorm + 0
           }
           save()

       }
           else {
           }
   }
    
  
    
    // MARK: Input form
    private var scoreform: some View {
        Form {
            Toggle(Team ? matchViewModel.matchArray.count == 0 ? "Home" : matchViewModel.matchArray[0].home : matchViewModel.matchArray.count == 0 ? "Op" : matchViewModel.matchArray[0].opponent , isOn: $Team)
                .foregroundColor(Team ? CustomMag.HC_Mag : .black)
                .toggleStyle(SwitchToggleStyle(tint: CustomMag.HC_Mag))
                .padding(.all)
            
            HStack {  Picker("Score", selection: $ScoreType) {
                Text("Goal").tag("G")
                Text("Behind").tag("B")
                Text("Miss").tag("M")
            }
            .pickerStyle(.segmented)
            .background(Team ? CustomMag.HC_Mag.opacity(0.3) : .gray.opacity(0.4))
            
                if ScoreType == "G"  && Team == true {
                    Picker("", selection: $goalName) {
                        Text("No Option").tag(Optional<String>(nil))
                        ForEach(playerViewModel.playerArray.sorted(by:  {if $0.Surname ==  $1.Surname {
                            return  $0.Given < $1.Given }
                             return $0.Surname < $1.Surname })
                        )
                        { player in
                            Text("\(player.Surname), \(player.Given) (\(player.Guernsey))")
                                .tag("\(player.Given) \(player.Surname) ")
                        }
                    }
                    
                    .tint(.black)
                   
                } else { }
            }
            
            Picker("Type", selection: $scoreOrigin) {
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
            .pickerStyle(.segmented)
            .background(Team ? CustomMag.HC_Mag.opacity(0.3) : .gray.opacity(0.4))
            
            Picker("ScoreType", selection: $launch) {
                Text("<40 W").tag("1")
                Text("<40 C").tag("2")
                Text("+40 C").tag("3")
                Text("+40 W").tag("4")
            }
            .pickerStyle(.segmented)
            .background(Team ? CustomMag.HC_Mag.opacity(0.3) : .gray.opacity(0.4))
            
                // Save button
            HStack {
                
                Spacer()
                Button {
                   scoreCounter()
                    scoreEventToNum()
                    updateScoreArray()
                    updateGoalkicker()
                  
                } label: {
                    Text("Save Score")
                        .padding()
                        .foregroundStyle(.white)
                        .background(CustomMag.HC_Mag)
                        .clipShape(Capsule())
                        .padding()
                }
            }
           
        }
        .frame(minHeight: 340)
        
       
    }
   // MARK: Scoreboard
    private var scoreboard: some View {
        HStack {
            VStack{
                Text("Quarter")
                    .frame(width: 80, height: 40)
                Text("Q1")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(CustomMag.HC_Mag)
                
                Text("Q2")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(CustomMag.HC_Mag)
                
                Text("Q3")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(CustomMag.HC_Mag)
                
                Text("Q4")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(CustomMag.HC_Mag)
                Text("Score")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(CustomMag.HC_Mag)
                Text("Total")
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(width: 80, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(CustomMag.HC_Mag)
            }
            // Haileybury scores
            VStack{
                Text(matchViewModel.matchArray.count == 0 ? "home" : matchViewModel.matchArray[0].homeAbbr)
                    .frame(width: 120, height: 40)
                Text("\(scoreNummerArray[24]  ?? 0) - \(scoreNummerArray[20]  ?? 0) (\(6 * (scoreNummerArray[24]  ?? 0) + (scoreNummerArray[20]  ?? 0)))")
                    .foregroundColor(quarterInt == 1 ? CustomMag.HC_Mag :  .gray )
                    .fontWeight(quarterInt == 1 ? .bold : .medium)
                    .frame(width: 120, height: 40)
                    .padding(.horizontal)
                    .border(CustomMag.HC_Mag)
                Text("\(scoreNummerArray[56]  ?? 0) - \(scoreNummerArray[52]  ?? 0) (\(6 * (scoreNummerArray[56]  ?? 0) + (scoreNummerArray[52]  ?? 0)))")
                    .foregroundColor(quarterInt == 2 ? CustomMag.HC_Mag :  .gray )
                    .fontWeight(quarterInt == 2 ? .bold : .medium)
                    .frame(width: 120, height: 40)
                    .padding(.horizontal)
                
                    .border(CustomMag.HC_Mag)
                Text("\(scoreNummerArray[88]  ?? 0) - \(scoreNummerArray[84]  ?? 0) (\(6 * (scoreNummerArray[88]  ?? 0) + (scoreNummerArray[84]  ?? 0)))")
                    .foregroundColor(quarterInt == 3 ? CustomMag.HC_Mag :  .gray )
                    .fontWeight(quarterInt == 3 ? .bold : .medium)
                    .frame(width: 120, height: 40)
                    .padding(.horizontal)
                    .border(CustomMag.HC_Mag)
                Text("\(scoreNummerArray[120]  ?? 0) - \(scoreNummerArray[116]  ?? 0) (\(6 * (scoreNummerArray[120]  ?? 0) + (scoreNummerArray[116]  ?? 0)))")
                    .foregroundColor(quarterInt == 4 ? CustomMag.HC_Mag :  .gray )
                    .fontWeight(quarterInt == 4 ? .bold : .medium)
                    .frame(width: 120, height: 40)
                    .padding(.horizontal)
                    .border(CustomMag.HC_Mag)
               
                Text("\(scoreTotalNummerArray[24]  ?? 0) - \(scoreTotalNummerArray[20]  ?? 0)")
                    .bold()
                    .frame(width: 120, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(CustomMag.HC_Mag)
                
                
                Text("\(6 * (scoreTotalNummerArray[24]  ?? 0) + (scoreTotalNummerArray[20]  ?? 0))")
                    .bold()
                    .frame(width: 120, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(CustomMag.HC_Mag)
            }
            // Opposition scores
            VStack{
                Text(matchViewModel.matchArray.count == 0 ? "Op" : matchViewModel.matchArray[0].oppAbbr)
                    .frame(width: 120, height: 40)
                Text("\(scoreNummerArray[8]  ?? 0) - \(scoreNummerArray[4]  ?? 0) (\(6 * (scoreNummerArray[8]  ?? 0) + (scoreNummerArray[4]  ?? 0)))")
                    .frame(width: 120, height: 40)
                    .foregroundColor(quarterInt == 1 ? .black :  .gray )
                    .fontWeight(quarterInt == 1 ? .bold : .medium)
                    .padding(.horizontal)
                    .border(CustomMag.HC_Mag)
                Text("\(scoreNummerArray[40]  ?? 0) - \(scoreNummerArray[36]  ?? 0) (\(6 * (scoreNummerArray[40]  ?? 0) + (scoreNummerArray[36]  ?? 0)))")
                    .foregroundColor(quarterInt == 2 ? .black : .gray )
                    .fontWeight(quarterInt == 2  ? .bold : .medium)
                    .frame(width: 120, height: 40)
                    .padding(.horizontal)
                    .border(CustomMag.HC_Mag)
                Text("\(scoreNummerArray[72]  ?? 0) - \(scoreNummerArray[68]  ?? 0) (\(6 * (scoreNummerArray[72]  ?? 0) + (scoreNummerArray[68]  ?? 0)))")
                    .foregroundColor(quarterInt == 3 ? .black :  .gray )
                    .fontWeight(quarterInt == 3 ? .bold : .medium)
                    .frame(width: 120, height: 40)
                    .padding(.horizontal)
                    .border(CustomMag.HC_Mag)
                Text("\(scoreNummerArray[104]  ?? 0) - \(scoreNummerArray[100]  ?? 0) (\(6 * (scoreNummerArray[104]  ?? 0) + (scoreNummerArray[100]  ?? 0)))")
                    .foregroundColor(quarterInt == 4  ? .black :  .gray )
                    .fontWeight(quarterInt == 4  ? .bold : .medium)
                    .frame(width: 120, height: 40)
                    .padding(.horizontal)
                    .border(CustomMag.HC_Mag)
                
                Text("\(scoreTotalNummerArray[8]  ?? 0) - \(scoreTotalNummerArray[4]  ?? 0)")
                    .bold()
                    .frame(width: 120, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(CustomMag.HC_Mag)
                
                Text("\(6 * (scoreTotalNummerArray[8]  ?? 0) + (scoreTotalNummerArray[4]  ?? 0))")
                    .bold()
                    .frame(width: 120, height: 40)
                    .padding(.horizontal)
                    .background(.gray.opacity(0.2))
                    .border(CustomMag.HC_Mag)
                
            }
            
        }
    }
    // MARK: goalkickers
    private var listOfScorers: some View {
        VStack {

            // MARK: Goalscorers
           
            let sortInfo = goalFreqArray.sorted(by: { $1.value < $0.value } )
           
            VStack {
                Text("Goalkickers")
                    .foregroundColor(CustomMag.HC_Mag)
                LazyVGrid(columns: columns, spacing: 0) {
                    //List {
                   
                    ForEach(sortInfo, id: \.key) { key, value in
                        
                        HStack {
                            Text(key)
                            Text("\(value)")
                        }
                    }
                }
            }
            
            Divider()
                .frame(height: 2)
                .overlay(.gray)
           
            Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 10) {
                       ForEach(scoreViewModel.scoreArray.reversed()) { score in
                           GridRow(alignment: .firstTextBaseline) {
                               Group {
                                //   Text("\(score.launchNummer)")
                                   Text("Q\(score.quarter)   \(score.scoreEvent )")
                                       .padding(.leading)
                                   Text("\(score.team == "HC" ? score.goalScorer : matchViewModel.matchArray.count == 0 ? "Op" : matchViewModel.matchArray[0].oppAbbr.trimmingCharacters(in: .whitespacesAndNewlines) )")
                                   Text( "(\(score.scoreType))")
                                   switch score.launchNummer - 32 * ((Int(score.quarter) ?? 0) - 1)   {
                                   case  0, 4, 8, 16, 20, 24 :
                                       Text("<W")
                                   case  1, 5, 9, 17, 21, 25 :
                                       Text("<C")
                                   case  2, 6, 10, 18, 22, 26 :
                                       Text("+C")
                                   case  3, 7, 11, 19, 23, 27 :
                                       Text("+W")
                                   default:
                                       Text("XX")
                                   }
                               }
                               .foregroundColor(score.team == "HC" ?  CustomMag.HC_Mag : .black)
                               .opacity(score.scoreEvent == "M" ? 0.4 : 1)
                               
                               Text("(\(score.HCWorm) - \(score.OpWorm))")
                                   .foregroundColor(score.HCWorm < score.OpWorm ? .red : .primary)
                                   .opacity(score.scoreEvent == "M" ? 0 : 1)
                               
                              
                                   
                           }
                           GridRow {
                               Rectangle()
                                   .fill(CustomMag.HC_Mag)
                                   .frame(height: 1)
                                   .gridCellColumns(4)
                                   .gridCellUnsizedAxes([.horizontal])
                           }
                       }
                   }
            
            
         
        }
    }
    
    func updateGoalkicker() {
        goalFreqArray = Dictionary( scoreViewModel.scoreArray.filter({ $0.scoreEvent == "G" && $0.team == "HC" }).map { ($0.goalScorer, 1) }, uniquingKeysWith: +)
    }
   
    func resetScore() {
        goalStringArray = [""]
        goalFreqArray = [:]
        HCWorm = 0
        OpWorm = 0
        showResetAlert = false
        scoreViewModel.scoreArray.removeAll()
       scoreViewModel.saveScore()
        dismiss()
    }
}
