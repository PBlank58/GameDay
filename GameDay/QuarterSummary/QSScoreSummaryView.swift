//
//  ScoreSummaryView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 27/9/2023.
//

import SwiftUI

struct QSScoreSummaryView: View {
    
    //Custom Colours
       struct CustomGold {static let HC_Gold = Color("HC_Gold")}
       struct CustomMag {static let HC_Mag = Color("HC_Magenta") }
    
    @StateObject var matchDetails = MatchViewModel()
    @StateObject var scoreViewModel = ScoreViewModel()
    @StateObject var teamViewModel = PlayerViewModel()
   
    // Covert string to array and back for AppStorage
    
    @State private var goalStringArray: [String] = []
    @State private var goalFreqArray: [String : Int] = [:]
    
    @State var showScoreArray = false
    @State var showScoreType = false
    // scoreMatrix
    
    @State private var scoreNummerArray: [Int : Int] = [:]
    @State private var scoreTotalNummerArray: [Int : Int] = [:]
    
    // MARK: PDF properties
       @State var PDFURL: URL?
       @State var showPDFSheet: Bool = false
    let columns = [
           GridItem(.adaptive(minimum: 300),alignment: .leading),
           ]
    
    var body: some View {
       ScrollView {
           if matchDetails.matchArray.count == 0 {
               Text("No game details")
                   .font(.title2)
           } else {
               HStack {
                   Spacer()
                   Text(matchDetails.matchArray[0].competition + " " + matchDetails.matchArray[0].level)
                       .font(.title2)
                   Text("\(matchDetails.matchArray[0].home) v ")
                       .font(.title2)
                   Text(matchDetails.matchArray[0].opponent )
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
            
           }
               Divider()
                   .frame(maxWidth: .infinity, minHeight: 2)
                   .overlay(CustomMag.HC_Mag)
               
               Text("Scoreboard")
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .foregroundColor(CustomMag.HC_Mag)
                   .padding()
                   .font(.title3)
               
               scoreboard
                   .padding()
               
               let sortInfo = goalFreqArray.sorted(by: { $1.value < $0.value } )
               
               Text("Goalkickers")
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .foregroundColor(CustomMag.HC_Mag)
                   .padding()
                   .font(.title2)
           LazyVGrid(columns: columns) {
                   ForEach(sortInfo, id: \.key) { key, value in
                       
                       HStack {
                          
                           Text("\(key) \(value)")
                               .padding(.leading, 100)
                       }
                       .padding()
                       
                       // .border(CustomMag.HC_Mag)
                   }
               }
               
              
              
            }
       .navigationTitle(" ")
       .navigationBarItems(
        trailing:
            HStack {
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
                Button {
                    //MARK: self is the current view
                    
                    exportPDF {
                        GameOutputView()
                    } completion: { status, url in
                        if let url = url,status{
                            self.PDFURL = url
                            self.showPDFSheet.toggle()
                        } else {
                            print("failed to produce pdf")
                        }
                    }
                } label: {
                    VStack {
                        Image(systemName: "square.and.arrow.up.fill")
                        Text("Save")
                    }
                    .foregroundColor(CustomMag.HC_Mag)
                }
            }
       )
       .sheet(isPresented: $showScoreArray) {
           ScoreArrayView()
       }
       .sheet(isPresented: $showScoreType) {
           ScoreTypeView()
       }
       .sheet(isPresented: $showPDFSheet) {
           PDFURL = nil
         } content: {
             if let PDFUrl = PDFURL {
                 ShareSheet(urls: [PDFUrl])
             }
         }
        .onAppear() {
            updateGoalkicker()
            }
        }
       
    }


struct QSScoreSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        QSScoreSummaryView()
    }
}
extension  QSScoreSummaryView {
    // MARK: reconstitue dictionary
    func updateGoalkicker() {
        goalFreqArray = Dictionary( scoreViewModel.scoreArray.filter({ $0.scoreEvent == "G"}).map { ($0.goalScorer, 1) }, uniquingKeysWith: +)
    }
   
    // MARK: Scoreboard
   
     private var scoreboard: some View {
         HStack {
             VStack{
                 Text("")
                     .foregroundColor(CustomMag.HC_Mag)
                     .frame(width: 80, height: 40)
                     .padding(.horizontal)
                    
                   
                   
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
                 Text(matchDetails.matchArray[0].homeAbbr)
                     .foregroundColor(CustomMag.HC_Mag)
                     .frame(width: 80, height: 40, alignment: .bottom)
                     .font(.headline)
                   
                 Text("\(scoreNummerArray[24]  ?? 0) - \(scoreNummerArray[20]  ?? 0) (\(6 * (scoreNummerArray[24]  ?? 0) + (scoreNummerArray[20]  ?? 0)))")
                     .frame(width: 80, height: 40)
                     .padding(.horizontal)
                     .border(CustomMag.HC_Mag)
                 Text("\(scoreNummerArray[56]  ?? 0) - \(scoreNummerArray[52]  ?? 0) (\(6 * (scoreNummerArray[56]  ?? 0) + (scoreNummerArray[52]  ?? 0)))")
                     .frame(width: 80, height: 40)
                     .padding(.horizontal)
                 
                     .border(CustomMag.HC_Mag)
                 Text("\(scoreNummerArray[88]  ?? 0) - \(scoreNummerArray[84]  ?? 0) (\(6 * (scoreNummerArray[88]  ?? 0) + (scoreNummerArray[84]  ?? 0)))")
                     .frame(width: 80, height: 40)
                     .padding(.horizontal)
                     .border(CustomMag.HC_Mag)
                 Text("\(scoreNummerArray[120]  ?? 0) - \(scoreNummerArray[116]  ?? 0) (\(6 * (scoreNummerArray[120]  ?? 0) + (scoreNummerArray[116]  ?? 0)))")
                     .frame(width: 80, height: 40)
                     .padding(.horizontal)
                     .border(CustomMag.HC_Mag)
                 Text("\(scoreTotalNummerArray[24]  ?? 0) - \(scoreTotalNummerArray[20]  ?? 0)")
                     .frame(width: 80, height: 40)
                     .padding(.horizontal)
                     .background(.gray.opacity(0.2))
                     .border(CustomMag.HC_Mag)
                 Text("\(6 * (scoreTotalNummerArray[24]  ?? 0) + (scoreTotalNummerArray[20]  ?? 0))")
                     .frame(width: 80, height: 40)
                     .padding(.horizontal)
                     .background(.gray.opacity(0.2))
                     .border(CustomMag.HC_Mag)
             }
           
             // Opposition scores
             VStack{
                 Text(matchDetails.matchArray.count == 0 ? "Op" : matchDetails.matchArray[0].oppAbbr)
                     .foregroundColor(CustomMag.HC_Mag)
                     .frame(width: 80, height: 40, alignment: .bottom)
                     .font(.headline)
                   
                 Text("\(scoreNummerArray[8]  ?? 0) - \(scoreNummerArray[4]  ?? 0) (\(6 * (scoreNummerArray[8]  ?? 0) + (scoreNummerArray[4]  ?? 0)))")
                     .frame(width: 80, height: 40)
                     .padding(.horizontal)
                     .border(CustomMag.HC_Mag)
                 Text("\(scoreNummerArray[40]  ?? 0) - \(scoreNummerArray[36]  ?? 0) (\(6 * (scoreNummerArray[40]  ?? 0) + (scoreNummerArray[36]  ?? 0)))")
                     .frame(width: 80, height: 40)
                     .padding(.horizontal)
                     .border(CustomMag.HC_Mag)
                 Text("\(scoreNummerArray[72]  ?? 0) - \(scoreNummerArray[68]  ?? 0) (\(6 * (scoreNummerArray[72]  ?? 0) + (scoreNummerArray[68]  ?? 0)))")
                     .frame(width: 80, height: 40)
                     .padding(.horizontal)
                     .border(CustomMag.HC_Mag)
                 Text("\(scoreNummerArray[104]  ?? 0) - \(scoreNummerArray[100]  ?? 0) (\(6 * (scoreNummerArray[104]  ?? 0) + (scoreNummerArray[100]  ?? 0)))")
                     .frame(width: 80, height: 40)
                     .padding(.horizontal)
                     .border(CustomMag.HC_Mag)
                 
                 Text("\(scoreTotalNummerArray[8]  ?? 0) - \(scoreTotalNummerArray[4]  ?? 0)")
                     .frame(width: 80, height: 40)
                     .padding(.horizontal)
                     .background(.gray.opacity(0.2))
                     .border(CustomMag.HC_Mag)
                 Text("\(6 * (scoreTotalNummerArray[8]  ?? 0) + (scoreTotalNummerArray[4]  ?? 0))")
                     .frame(width: 80, height: 40)
                     .padding(.horizontal)
                     .background(.gray.opacity(0.2))
                     .border(CustomMag.HC_Mag)
                 
             }
             
         }
         .font(.caption)
         .onAppear() {
             updateQSScoreArray()
             updateQSGoalkicker()
         }
     }
    func updateQSGoalkicker() {
        goalFreqArray = Dictionary( scoreViewModel.scoreArray.filter({ $0.scoreEvent == "G"}).map { ($0.goalScorer, 1) }, uniquingKeysWith: +)
    }
    func updateQSScoreArray() {
        
    scoreNummerArray = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 124), 1) }, uniquingKeysWith: +)
    scoreTotalNummerArray  = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 28), 1) }, uniquingKeysWith: +)
      
    }
}
