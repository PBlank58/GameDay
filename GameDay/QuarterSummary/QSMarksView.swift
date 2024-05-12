//
//  QSMarksView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 20/9/2023.
//

import SwiftUI

struct QSMarksView: View {
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }
    
    @AppStorage("hcmarks") var hcmarks = ""
    @AppStorage("opmarks") var opmarks = ""
    
    @State private var hcMarksArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @State private var opMarksArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    var body: some View {
        HStack {
            Group {
                Text("Total Marks")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
              //  First Quarter
                let marksHC1 = hcMarksArray[0] + hcMarksArray[4] + hcMarksArray[8] + hcMarksArray[12] + hcMarksArray[16] + hcMarksArray[20]
                let marksOp1 = opMarksArray[0] + opMarksArray[4] + opMarksArray[8] + opMarksArray[12] + opMarksArray[16] + opMarksArray[20]
                let marks1diff = marksHC1 - marksOp1
               Text("\(marks1diff)")
                   .foregroundColor(marks1diff >= 0 ? .black : .red)
                    .padding()
                   .frame(width: 70, height: 45)
                    .border(.gray)
               // Second Quarter
                let marksHC2 = hcMarksArray[1] + hcMarksArray[5] + hcMarksArray[9] + hcMarksArray[13] + hcMarksArray[17] + hcMarksArray[21]
                let marksOp2 = opMarksArray[1] + opMarksArray[5] + opMarksArray[9] + opMarksArray[13] + opMarksArray[17] + opMarksArray[21]
                let marks2diff = marksHC2 - marksOp2
                Text("\(marks2diff)")
                    .foregroundColor(marks2diff >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                   .border(.gray)
                   .background(.gray.opacity(0.1))
               // Third Quarter
                let marksHC3 = hcMarksArray[2] + hcMarksArray[6] + hcMarksArray[10] + hcMarksArray[14] + hcMarksArray[18] + hcMarksArray[22]
                let marksOp3 = opMarksArray[2] + opMarksArray[6] + opMarksArray[10] + opMarksArray[14] + opMarksArray[18] + opMarksArray[22]
                let marks3diff = marksHC3 - marksOp3
               Text("\(marks3diff)")
                   .foregroundColor(marks3diff >= 0 ? .black : .red)
                    .padding()
                   .frame(width: 70, height: 45)
                    .border(.gray)
               // Fourth Quarter
                let marksHC4 = hcMarksArray[3] + hcMarksArray[7] + hcMarksArray[11] + hcMarksArray[15] + hcMarksArray[19] + hcMarksArray[23]
                let marksOp4 = opMarksArray[3] + opMarksArray[7] + opMarksArray[11] + opMarksArray[15] + opMarksArray[19] + opMarksArray[23]
                let marks4diff = marksHC4 - marksOp4
                Text("\(marks4diff)")
                    .foregroundColor(marks4diff >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                   .border(.gray)
                   .background(.gray.opacity(0.1))
               //Totals
                Text("\(hcMarksArray[0...23].reduce(0,+) - opMarksArray[0...23].reduce(0,+))")
                    .foregroundColor(hcMarksArray[0...23].reduce(0,+) - opMarksArray[0...23].reduce(0,+) >= 0 ? .black : .red)
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
            updateMarksArrays()
        }
    }
      
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
    }
}

struct QSMarksView_Previews: PreviewProvider {
    static var previews: some View {
        QSMarksView()
    }
}
