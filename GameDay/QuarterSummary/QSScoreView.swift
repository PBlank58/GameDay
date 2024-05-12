//
//  QSScoreView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 21/9/2023.
//

import SwiftUI

struct QSScoreView: View {
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }

    @ObservedObject var scoreViewModel = ScoreViewModel()

    // scoreMatrix
    @State private var scoreNummerArray: [Int : Int] = [:]
    @State private var scoreTotalNummerArray: [Int : Int] = [:]
    @State private var quarterWin1 = 0
    @State private var quarterWin2 = 0
    @State private var quarterWin3 = 0
    @State private var quarterWin4 = 0
    @State private var quarterWinT = 0
    
    var body: some View {
        ScrollView {
            HStack {
                Group {
                  
                    Text("Points For")
                        .foregroundColor(CustomMag.HC_Mag)
                        .padding()
                        .frame(width: 260, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.3))
                        .padding(.horizontal)
                    // First Quarter
                    Text("\(6 * (scoreNummerArray[24]  ?? 0) + (scoreNummerArray[20]  ?? 0))")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                    // Second Quarter
                    Text("\(6 * (scoreNummerArray[56]  ?? 0) + (scoreNummerArray[52]  ?? 0))")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    // Third Quarter
                    Text("\(6 * (scoreNummerArray[88]  ?? 0) + (scoreNummerArray[84]  ?? 0))")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                    
                    // Fourth Quarter
                    Text("\(6 * (scoreNummerArray[120]  ?? 0) + (scoreNummerArray[116]  ?? 0))")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    //Totals
                    Text("\(6 * (scoreTotalNummerArray[24]  ?? 0) + (scoreTotalNummerArray[20]  ?? 0))")
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
                    Text("Points Against")
                        .foregroundColor(CustomMag.HC_Mag)
                        .padding()
                        .frame(width: 260, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.3))
                        .padding(.horizontal)
                    // First Quarter
                    Text("\(6 * (scoreNummerArray[8]  ?? 0) + (scoreNummerArray[4]  ?? 0))")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                    // Second Quarter
                    Text("\(6 * (scoreNummerArray[40]  ?? 0) + (scoreNummerArray[36]  ?? 0))")
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    // Third Quarter
                    Text("\(6 * (scoreNummerArray[72]  ?? 0) + (scoreNummerArray[68]  ?? 0))")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                    
                    // Fourth Quarter
                    Text("\(6 * (scoreNummerArray[104]  ?? 0) + (scoreNummerArray[100]  ?? 0))")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    //Totals
                    Text("\(6 * (scoreTotalNummerArray[8]  ?? 0) + (scoreTotalNummerArray[4]  ?? 0))")
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
                    Text("Difference")
                        .foregroundColor(CustomMag.HC_Mag)
                        .padding()
                        .frame(width: 260, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.3))
                        .padding(.horizontal)
                    // First Quarter
                    Text("\(quarterWin1)")
                        .padding()
                        .frame(width: 70, height: 45)
                        .foregroundColor(quarterWin1 < 0 ? .red : .black)
                        .border(.gray)
                    // Second Quarter
                    Text("\(quarterWin2 - quarterWin1)")
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .foregroundColor(quarterWin2 - quarterWin1 < 0 ? .red : .black)
                        .background(.gray.opacity(0.1))
                    // Third Quarter
                    Text("\(quarterWin3 - quarterWin2)")
                        .padding()
                        .frame(width: 70, height: 45)
                        .foregroundColor(quarterWin3 - quarterWin2 < 0 ? .red : .black)
                        .border(.gray)
                    
                    // Fourth Quarter
                    Text("\(quarterWin4 - quarterWin3)")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .foregroundColor(quarterWin4 - quarterWin3 < 0 ? .red : .black)
                        .background(.gray.opacity(0.1))
                    //Totals
                    Text("\(quarterWinT)")
                        .padding()
                        .frame(width: 100, height: 45)
                        .background(CustomMag.HC_Mag.opacity(0.1))
                        .foregroundColor(quarterWinT < 0 ? .red : .black)
                        .border(.gray)
                        .padding(.horizontal)
                    
                }
            }
            .font(.title3)
          
            HStack {
                Group {
                    Text("Quarter Win")
                        .foregroundColor(CustomMag.HC_Mag)
                        .padding()
                        .frame(width: 260, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.3))
                        .padding(.horizontal)
                    
               
                    if     quarterWin1 == 0 || scoreViewModel.scoreArray.count == 0 {
                        Text("\(Image(systemName: "minus"))")
                            .foregroundColor(.gray)
                            .bold()
                            .padding()
                            .frame(width: 70, height: 45)
                            .border(.gray)
                            .background(.gray.opacity(0.1))
                    } else {
                    Text("\(quarterWin1 < 0 ? Image(systemName: "multiply") : Image(systemName: "checkmark") )")
                        .foregroundColor(quarterWin1 < 0 ? .red : .green)
                        .bold()
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                }
                    // Second Quarter
                    if quarterWin2 - quarterWin1 == 0 || scoreViewModel.scoreArray.count == 0  {
                        Text("\(Image(systemName: "minus"))")
                            .foregroundColor(.gray)
                            .bold()
                            .padding()
                            .frame(width: 70, height: 45)
                            .border(.gray)
                            .background(.gray.opacity(0.1))
                    } else {
                    Text("\(quarterWin2 - quarterWin1 < 0 ? Image(systemName: "multiply") : Image(systemName: "checkmark") )")
                        .foregroundColor(quarterWin2 - quarterWin1  < 0 ? .red : .green)
                        .bold()
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                }
                    // Third Quarter
                    if quarterWin3 - quarterWin2 == 0 || scoreViewModel.scoreArray.count == 0 {
                        Text("\(Image(systemName: "minus"))")
                            .bold()
                            .foregroundColor(.gray)
                            .padding()
                            .frame(width: 70, height: 45)
                            .border(.gray)
                            .background(.gray.opacity(0.1))
                    } else {
                        Text("\(quarterWin3 - quarterWin2  < 0 ? Image(systemName: "multiply") : Image(systemName: "checkmark") )")
                        .foregroundColor(quarterWin3 - quarterWin2   < 0 ? .red : .green)
                        .bold()
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                }
                    // Fourth Quarter
                    if quarterWin4 - quarterWin3  == 0 || scoreViewModel.scoreArray.count == 0  {
                        Text("\(Image(systemName: "minus"))")
                            .foregroundColor(.gray)
                            .bold()
                            .padding()
                            .frame(width: 70, height: 45)
                            .border(.gray)
                            .background(.gray.opacity(0.1))
                    } else {
                        Text("\(quarterWin4 - quarterWin3  < 0 ? Image(systemName: "multiply") : Image(systemName: "checkmark") )")
                            .foregroundColor(quarterWin4 - quarterWin3  < 0 ? .red : .green)
                            .bold()
                            .padding()
                            .frame(width: 70, height: 45)
                            .border(.gray)
                            .background(.gray.opacity(0.1))
                    }
                    //Totals
                    if quarterWinT == 0 || scoreViewModel.scoreArray.count == 0 {
                        Text("\(Image(systemName: "minus"))")
                            .foregroundColor(.gray)
                            .bold()
                            .padding()
                            .frame(width: 100, height: 45)
                            .background(CustomMag.HC_Mag.opacity(0.1))
                            .border(.gray)
                            .padding(.horizontal)
                    } else {
                        Text("\(quarterWinT < 0 ? Image(systemName: "multiply") : Image(systemName: "checkmark") )")
                            .foregroundColor(quarterWinT < 0 ? .red : .green)
                            .bold()
                            .padding()
                            .frame(width: 100, height: 45)
                            .background(CustomMag.HC_Mag.opacity(0.1))
                            .border(.gray)
                            .padding(.horizontal)
                    }
                }
            }
            .font(.title3)
        }
        
        .onAppear() {
            updateQSScoreArray()
            quarterWin1 = (scoreViewModel.scoreArray.filter({$0.quarter == "1"}).last?.HCWorm ?? 0) - (scoreViewModel.scoreArray.filter({$0.quarter == "1"}).last?.OpWorm ?? 0)
            quarterWin2 = (scoreViewModel.scoreArray.filter({$0.quarter == "2"}).last?.HCWorm ?? 0) - (scoreViewModel.scoreArray.filter({$0.quarter == "2"}).last?.OpWorm ?? 0)
            quarterWin3 = (scoreViewModel.scoreArray.filter({$0.quarter == "3"}).last?.HCWorm ?? 0) - (scoreViewModel.scoreArray.filter({$0.quarter == "3"}).last?.OpWorm ?? 0)
            quarterWin4 = (scoreViewModel.scoreArray.filter({$0.quarter == "4"}).last?.HCWorm ?? 0) - (scoreViewModel.scoreArray.filter({$0.quarter == "4"}).last?.OpWorm ?? 0)
            quarterWinT = (scoreViewModel.scoreArray.last?.HCWorm ?? 0) - (scoreViewModel.scoreArray.last?.OpWorm ?? 0)
          
        }
    }
      

 
  
}
struct QSScoreView_Previews: PreviewProvider {
    static var previews: some View {
        QSScoreView()
    }
}
extension QSScoreView {
    // uses ScoreViewModel to update table
    func updateQSScoreArray() {
        
    scoreNummerArray = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 124), 1) }, uniquingKeysWith: +)
    scoreTotalNummerArray  = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 28), 1) }, uniquingKeysWith: +)
       
      
    }
}
