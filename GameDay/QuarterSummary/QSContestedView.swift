//
//  QSOtherClearanceView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 20/9/2023.
//

import SwiftUI

struct QSContestedView: View {
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }
    
   
    
    @AppStorage("contested") var contested = ""
    @State private var contestedArray: [Int]  = [0,0,0,0,0,0,0,0]
    
    var body: some View {
        HStack {
            Group {
                Text("Contested Ball")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                Text("\(contestedArray[0]-contestedArray[4])")
                    .foregroundColor(contestedArray[0] - contestedArray[4] >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(contestedArray[1]-contestedArray[5])")
                    .foregroundColor(contestedArray[1]-contestedArray[5] >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(contestedArray[2]-contestedArray[6])")
                    .foregroundColor(contestedArray[2]-contestedArray[6] >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    
                // Fourth Quarter
                Text("\(contestedArray[3]-contestedArray[7])")
                    .foregroundColor(contestedArray[3] - contestedArray[7] >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(contestedArray[0...3].reduce(0,+) - contestedArray[4...7].reduce(0,+))")
                    .foregroundColor(contestedArray[0...3].reduce(0,+) - contestedArray[4...7].reduce(0,+) >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 100, height: 45)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                    .padding(.horizontal)
                   
            }
        }
        .font(.title3)
        
        Divider()
            .frame(maxWidth: .infinity, minHeight: 1)
            .overlay(.gray)
        
        .onAppear() {
            updateContestedArrays()
        }
    }
      
     private func updateContestedArrays() {
        // Contested
        if contested == "" {
            contested = "0,0,0,0,0,0,0,0"
            contestedArray  = [0,0,0,0,0,0,0,0]
        } else {
            contestedArray = contested.components(separatedBy: ",").map { Int($0) ?? 0 }
        }
    }
}

struct QSOtherClearanceView_Previews: PreviewProvider {
    static var previews: some View {
        QSContestedView()
    }
}
