//
//  LSMidsView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 17/4/2024.
//

import SwiftUI

struct LSMidsView: View {
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }
    @StateObject var matchDetails: MatchViewModel
    
    
    @AppStorage("contested") var contested = ""
    @State private var contestedArray: [Int]  = [0,0,0,0,0,0,0,0]
    
    @State var clearanceArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @AppStorage("clearance") var clearance = ""
    
    @AppStorage("tackles") var tackles = ""
    @State private var tacklesArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0]
    
    @AppStorage("chain") var chain = ""
    @State private var ChainArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    @AppStorage("pressure") var pressure = ""
    @State private var pressureArray: [Int]  = [0,0,0,0,0,0,0,0]

    @AppStorage("repeatS") var repeatS = ""
    @State private var repeatArray: [Int]  = [0,0,0,0,0,0,0,0]
  
   
    
    var body: some View {
       
        HStack {
            Group {
                Text("Stoppage Wins")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                Text("\(clearanceArray[0] + clearanceArray[4])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(clearanceArray[1] + clearanceArray[5])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(clearanceArray[2] + clearanceArray[6] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    
                // Fourth Quarter
                Text("\(clearanceArray[3] + clearanceArray[7] )")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(clearanceArray[0...7].reduce(0,+))")
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
                Text("Stoppage Loses")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                Text("\(clearanceArray[8] + clearanceArray[12])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(clearanceArray[9] + clearanceArray[13])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(clearanceArray[10] + clearanceArray[14])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    
                // Fourth Quarter
                Text("\(clearanceArray[11] + clearanceArray[15])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(clearanceArray[8...15].reduce(0,+))")
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
                Text("Stoppage Difference")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                let Q1diff = clearanceArray[0] + clearanceArray[4] - clearanceArray[8] - clearanceArray[12]
                Text("\(Q1diff)")
                    .foregroundColor(Q1diff  >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                let Q2diff = clearanceArray[1] + clearanceArray[5] - clearanceArray[9] - clearanceArray[13]
                Text("\(Q2diff)")
                    .foregroundColor(tacklesArray[5] >= 5 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                let Q3diff = clearanceArray[2] + clearanceArray[6] - clearanceArray[10] - clearanceArray[14]
                Text("\(Q3diff )")
                    .foregroundColor(Q3diff >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    
                // Fourth Quarter
                let Q4diff = clearanceArray[3] + clearanceArray[7] - clearanceArray[11] - clearanceArray[15]
                Text("\(Q4diff )")
                    .foregroundColor(Q4diff >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(Q1diff + Q2diff + Q3diff + Q4diff)")
                    .foregroundColor( Q1diff + Q2diff + Q3diff + Q4diff >= 0 ? .black : .red)
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
                Text("Midfield tackles")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                Text("\(tacklesArray[4])")
                    .foregroundColor(tacklesArray[4]  >= 5 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(tacklesArray[5])")
                    .foregroundColor(tacklesArray[5] >= 5 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(tacklesArray[6] )")
                    .foregroundColor(tacklesArray[6] >= 5 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    
                // Fourth Quarter
                Text("\(tacklesArray[7] )")
                    .foregroundColor(tacklesArray[7]  >= 5 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(tacklesArray[4...7].reduce(0,+))")
                    .foregroundColor( tacklesArray[4...7].reduce(0,+) >= 20 ? .black : .red)
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
                Text("Non Contested Gain")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                Text("\(pressureArray[0])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(pressureArray[1])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(pressureArray[2])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    
                // Fourth Quarter
                Text("\(pressureArray[3])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(pressureArray[0...7].reduce(0,+))")
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
                Text("\(matchDetails.matchArray.count == 0 ? "Op" : matchDetails.matchArray[0].oppAbbr.trimmingCharacters(in: .whitespacesAndNewlines)) Successful Chain")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                Text("\(ChainArray[0] + ChainArray[8])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(ChainArray[1] + ChainArray[9])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(ChainArray[2] + ChainArray[10])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    
                // Fourth Quarter
                Text("\(ChainArray[3] + ChainArray[11])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(ChainArray[0...4].reduce(0,+) + ChainArray[8...11].reduce(0,+))")
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
                Text("\(matchDetails.matchArray.count == 0 ? "Op" : matchDetails.matchArray[0].oppAbbr.trimmingCharacters(in: .whitespacesAndNewlines)) UnSuccessful Chain")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                Text("\(ChainArray[4] + ChainArray[12])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(ChainArray[5] + ChainArray[13])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(ChainArray[6] + ChainArray[14])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    
                // Fourth Quarter
                Text("\(ChainArray[7] + ChainArray[15])")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(ChainArray[4...7].reduce(0,+) + ChainArray[12...15].reduce(0,+))")
                    .padding()
                    .frame(width: 100, height: 45)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                    .padding(.horizontal)
                   
            }
        }
        .font(.title2)
            .onAppear() {
               updateMidsLS()
            }
    }
    private func updateMidsLS() {
       // Contested
       if contested == "" {
           contested = "0,0,0,0,0,0,0,0"
           contestedArray  = [0,0,0,0,0,0,0,0]
       } else {
           contestedArray = contested.components(separatedBy: ",").map { Int($0) ?? 0 }
       }
        // Clearance
        if clearance == "" {
            clearance = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
            clearanceArray  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        } else {
            clearanceArray = clearance.components(separatedBy: ",").map { Int($0) ?? 0 }
             }
        // Tackles
        if tackles == "" {
            tackles = "0,0,0,0,0,0,0,0,0,0,0,0"
            tacklesArray = [0,0,0,0,0,0,0,0,0,0,0,0]
        } else {
            
            tacklesArray = tackles.components(separatedBy: ",").map { Int($0) ?? 0 }
        }
        if  chain == "" {
            chain = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
            ChainArray  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
            
        } else {
            ChainArray = chain.components(separatedBy: ",").map { Int($0) ?? 0  }
            }
        if pressure == "" {
            pressure = "0,0,0,0,0,0,0,0"
            pressureArray  = [0,0,0,0,0,0,0,0]
        } else {
          
            pressureArray = pressure.components(separatedBy: ",").map { Int($0) ?? 0 }
              }
        if repeatS == "" {
            repeatS = "0,0,0,0,0,0,0,0"
            repeatArray  = [0,0,0,0,0,0,0,0]
        } else {
            repeatArray = repeatS.components(separatedBy: ",").map { Int($0) ?? 0 }
              }
   }
}

#Preview {
    LSMidsView(matchDetails: MatchViewModel())
}
