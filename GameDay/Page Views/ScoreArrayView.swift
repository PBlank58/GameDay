//
//  ScoreArrayView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 22/9/2023.
//

import SwiftUI

struct ScoreArrayView: View {
    
    @StateObject var matchViewModel = MatchViewModel()
    @StateObject var scoreViewModel = ScoreViewModel()
    
    @State private var  quarterArray = "1"
    @State private var  quarterNo = "1"
    @State private var quarterTitle = "First"
    @State private var  quarterTeam = true
    @State private var arraySelection = "11"
   
    
    // Score Position Array
  // quarter view  for body data
    @State private var LaunchMatrixFrequencyArray: [Int : Int] = [:]
    //quarter view row total
    @State private var LaunchMatrixFrequencyFilter: [Int : Int] = [:]
    //quarter view column totals
    @State private var LaunchMatrixFrequencyFilterBT: [Int : Int] = [:]
    // total view for body data
    @State private var LaunchMatrixFrequencyFilterGT: [Int : Int] = [:]
    // total view for row total
    @State private var LaunchMatrixFrequencyFilterRT: [Int : Int] = [:]
    // total view for column total
    @State private var LaunchMatrixFrequencyFilterCT: [Int : Int] = [:]
    //grand total by quarter
    @State private var  LaunchMatrixFrequencyFilterQuarter: [Int : Int] = [:]
    //grand total by team
    @State private var  LaunchMatrixFrequencyFilterTeam: [Int : Int] = [:]
    
    
    @Environment(\.dismiss) private var dismiss
    //Custom Colours
    struct CustomGold {static let HC_Gold = Color("HC_Gold")}
    struct CustomMag {static let HC_Mag = Color("HC_Magenta") }
    
    var body: some View {
        
        NavigationStack {
            Toggle(quarterTeam ? matchViewModel.matchArray[0].home : matchViewModel.matchArray.count == 0 ? "Op" : matchViewModel.matchArray[0].opponent , isOn: $quarterTeam )
                .foregroundColor(quarterTeam  ? CustomMag.HC_Mag : .primary)
                .toggleStyle(SwitchToggleStyle(tint: CustomMag.HC_Mag))
                .padding(.all)
            Picker("Quarter", selection: $quarterNo) {
                Text("1")
                    .tag("1")
                Text("2")
                    .tag("2")
                Text("3")
                    .tag("3")
                Text("4")
                    .tag("4")
                Text("T")
                    .tag("5")
            }
            .pickerStyle(.segmented)
            .border(.gray)
            .padding(.bottom)
           
            Group {
               
                HStack {
                    if quarterNo == "1" {
                        
                        Text("First").bold()
                            .foregroundColor(CustomMag.HC_Mag) .padding()
                            .frame(width: 95, height: 50)
                            .border(.gray)
                            .background(.gray.opacity(0.1))
                    } else if quarterNo == "2"  {
                        Text("Second").bold()
                            .foregroundColor(CustomMag.HC_Mag) .padding()
                            .frame(width: 95, height: 50)
                            .border(.gray)
                            .background(.gray.opacity(0.1))
                    } else if quarterNo == "3"  {
                        Text("Third").bold()
                            .foregroundColor(CustomMag.HC_Mag) .padding()
                            .frame(width: 95, height: 50)
                            .border(.gray)
                            .background(.gray.opacity(0.1))
                    } else if quarterNo == "4" {
                        Text("Fourth").bold()
                            .foregroundColor(CustomMag.HC_Mag) .padding()
                            .frame(width: 95, height: 50)
                            .border(.gray)
                            .background(.gray.opacity(0.1))
                    }
                    else {
                        Text("Game").bold()
                            .foregroundColor(CustomMag.HC_Mag) .padding()
                            .frame(width: 95, height: 50)
                            .border(.gray)
                            .background(.gray.opacity(0.1))
                    }
                    Text("Inside 40")
                        .padding()
                        .frame(width: 100, height: 50)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    Text("Outside 40")
                        .padding()
                        .frame(width: 100, height: 50)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    Text("Total")
                        .padding()
                        .frame(width: 100, height: 50)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                }
                .font(.caption)
               
            }
            Group {
                HStack {
                    Text("")
                        .padding()
                        .frame(width: 95, height: 25)
                    
                        
                    Text("w")
                        .padding()
                        .frame(width: 50, height: 25)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                     
                    Text("c")
                        .padding()
                        .frame(width: 50, height: 25)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                       
                    Text("c")
                        .padding()
                        .frame(width: 50, height: 25)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                       
                    Text("w")
                        .padding()
                        .frame(width: 50, height: 25)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                        
                    Text("")
                        .padding()
                        .frame(width: 95, height: 25)
                }
                .font(.caption2)
              
            }
            ScrollView {
                Group {
                    HStack {
                        Text("Goal")
                            .padding()
                            .frame(width: 95, height: 50)
                            .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                            .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                            .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // Column 1
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterGT[(quarterTeam ? 16 : 0) + 8]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyArray[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 8]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // Column 2
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterGT[(quarterTeam ? 16 : 0) + 9]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyArray[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 9]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // Column 3
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterGT[(quarterTeam ? 16 : 0) + 10]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyArray[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 10]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // Column 4
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterGT[(quarterTeam ? 16 : 0) + 11]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyArray[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 11]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // row total
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterRT[(quarterTeam ? 16 : 0) + 8]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyFilter[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 8]  ?? 0)")
                        .padding()
                        .frame(width: 95, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                    }
                    .font(.caption)
                    .foregroundColor(quarterTeam ? CustomMag.HC_Mag : .black.opacity(0.6))
                    .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                }
                Group {
                    HStack {
                        Text("Behind")
                            .padding()
                            .frame(width: 95, height: 50)
                            .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                            .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                            .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // column 1
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterGT[(quarterTeam ? 16 : 0) + 4]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyArray[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 4]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // Column 2
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterGT[(quarterTeam ? 16 : 0) + 5]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyArray[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 5]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // Column 3
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterGT[(quarterTeam ? 16 : 0) + 6]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyArray[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 6]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // Column 4
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterGT[(quarterTeam ? 16 : 0) + 7]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyArray[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 7]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // Total
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterRT[(quarterTeam ? 16 : 0) + 4]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyFilter[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 4]  ?? 0)")
                        .padding()
                        .frame(width: 95, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                    }
                    .font(.caption)
                    .foregroundColor(quarterTeam ? CustomMag.HC_Mag : .black.opacity(0.6))
                }
                Group {
                    HStack {
                        Text("Miss")
                            .padding()
                            .frame(width: 95, height: 50)
                            .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                            .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                            .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // Column 1
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterGT[(quarterTeam ? 16 : 0) + 0]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyArray[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 0]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // Column 2
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterGT[(quarterTeam ? 16 : 0) + 1]  ?? 0)"
                             :"\(LaunchMatrixFrequencyArray[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 1]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // Column 3
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterGT[(quarterTeam ? 16 : 0) + 2]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyArray[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 2]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // Column4
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterGT[(quarterTeam ? 16 : 0) + 3]  ?? 0)"
                             : "\(LaunchMatrixFrequencyArray[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 3]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        // Total
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterRT[(quarterTeam ? 16 : 0) + 0]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyFilter[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 0]  ?? 0)")
                        .padding()
                        .frame(width: 95, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.white : Color.gray.opacity(0.1) )
                        
                    }
                    .font(.caption)
                    
                }
                .foregroundColor(quarterTeam ? CustomMag.HC_Mag : .black.opacity(0.6))
                
                Group {
                    HStack {
                        Text("Total").bold()
                            .padding()
                            .frame(width: 95, height: 50)
                            .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                            .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                            .foregroundColor(CustomMag.HC_Mag)
                            .background(quarterTeam ? Color.gray.opacity(0.1) : Color.white)
                        // Columnn 1
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterCT[(quarterTeam ? 16 : 0) + 0]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyFilterBT[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 0]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .foregroundColor(CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.gray.opacity(0.1) : Color.white)
                        // Column 2
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterCT[(quarterTeam ? 16 : 0) + 1]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyFilterBT[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 1]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .foregroundColor(CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.gray.opacity(0.1) : Color.white)
                        // Column 3
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterCT[(quarterTeam ? 16 : 0) + 2]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyFilterBT[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 2]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .foregroundColor(CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.gray.opacity(0.1) : Color.white)
                        // Column 4
                        Text(quarterNo == "5" ?
                             "\(LaunchMatrixFrequencyFilterCT[(quarterTeam ? 16 : 0) + 3]  ?? 0)"
                             :
                                "\(LaunchMatrixFrequencyFilterBT[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) + 3]  ?? 0)")
                        .padding()
                        .frame(width: 50, height: 50)
                        .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                        .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                        .foregroundColor(CustomMag.HC_Mag)
                        .background(quarterTeam ? Color.gray.opacity(0.1) : Color.white)
                        // Total
                        Text(quarterNo == "5" ? 
                             "\(LaunchMatrixFrequencyFilterTeam[(quarterTeam ? 16 : 0)] ?? 0)" : 
                                "\(LaunchMatrixFrequencyFilterQuarter[((Int(quarterNo) ?? 0) - 1) * 32 + (quarterTeam ? 16 : 0) ]  ?? 0)")
                            .padding()
                            .frame(width: 95, height: 50)
                            .border(quarterNo == "5" ? CustomMag.HC_Mag : .gray)
                            .foregroundColor(quarterNo == "5" ? .primary : CustomMag.HC_Mag)
                            .background(quarterTeam ? Color.gray.opacity(0.1) : Color.white)
                    }
                    .font(.caption)
                    Spacer()
                }
            }
                
              
            
                       .navigationBarTitle("Score Array")
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
        .onAppear() {
            updateScoreArray()
        }
    }
    
   
    
    func updateScoreArray() {
     
       // quarter view body data
     LaunchMatrixFrequencyArray = Dictionary( scoreViewModel.scoreArray.map { ($0.launchNummer & 127, 1) }, uniquingKeysWith: +)
        // quarter view  Row totals
      LaunchMatrixFrequencyFilter = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 124), 1) }, uniquingKeysWith: +)
        // quarter view Column Totals
        LaunchMatrixFrequencyFilterBT = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 115), 1) }, uniquingKeysWith: +)
       
        //GrandTotals body view
            LaunchMatrixFrequencyFilterGT = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 31), 1) }, uniquingKeysWith: +)
        //GrandTotals Row Totals
        LaunchMatrixFrequencyFilterRT = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 28), 1) }, uniquingKeysWith: +)
        //GrandTotals Column Totals
        LaunchMatrixFrequencyFilterCT = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 19), 1) }, uniquingKeysWith: +)
        //GrandTotals Quarter Team
        LaunchMatrixFrequencyFilterQuarter = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 112), 1) }, uniquingKeysWith: +)
        //GrandTotals Game Team
        LaunchMatrixFrequencyFilterTeam = Dictionary( scoreViewModel.scoreArray.map { (($0.launchNummer & 16), 1) }, uniquingKeysWith: +)
       print("1. \(LaunchMatrixFrequencyArray)")
      print("2. \(LaunchMatrixFrequencyFilter)")
       print("3. \(LaunchMatrixFrequencyFilterBT)")
       print("total body \(LaunchMatrixFrequencyFilterGT)")
      print("tot row \(LaunchMatrixFrequencyFilterRT)")
      print("tot col \(LaunchMatrixFrequencyFilterCT)")
      
    
    }
   
}
struct ScoreArrayView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreArrayView()
    }
}
