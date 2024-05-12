//
//  QSTackles.swift
//  GameDay
//
//  Created by Brett Pullyblank on 20/9/2023.
//

import SwiftUI

struct QSTacklesView: View {
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }
    
    @AppStorage("tackles") var tackles = ""
    @State private var tacklesArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0]
    
    var body: some View {
        HStack {
            Group {
                Text("Tackles     - total")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                Text("\(tacklesArray[0]+tacklesArray[4] + tacklesArray[8])")
                    .foregroundColor(tacklesArray[0]+tacklesArray[4] + tacklesArray[8] >= 10 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(tacklesArray[1]+tacklesArray[5] + tacklesArray[9])")
                    .foregroundColor(tacklesArray[1]+tacklesArray[5] + tacklesArray[9] >= 10 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(tacklesArray[2]+tacklesArray[6] + tacklesArray[10])")
                    .foregroundColor(tacklesArray[2]+tacklesArray[6] + tacklesArray[10] >= 10 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    
                // Fourth Quarter
                Text("\(tacklesArray[3]+tacklesArray[7] + tacklesArray[11])")
                    .foregroundColor(tacklesArray[3]+tacklesArray[7] + tacklesArray[11] >= 10 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(tacklesArray[0...11].reduce(0,+))")
                    .foregroundColor( tacklesArray[0...11].reduce(0,+) >= 40 ? .black : .red)
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
                Text("   -inside 40")
                    .padding()
                    .frame(width: 260, height: 45 , alignment: .trailing)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                    .padding(.horizontal)
                // First Quarter
                Text("\(tacklesArray[0])")
                    .foregroundColor(tacklesArray[0] >= 2 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(tacklesArray[1])")
                    .foregroundColor(tacklesArray[1] >= 2 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(tacklesArray[2])")
                    .foregroundColor(tacklesArray[2] >= 2 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                   
                // Fourth Quarter
                Text("\(tacklesArray[3])")
                    .foregroundColor(tacklesArray[3] >= 2 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(tacklesArray[0...3].reduce(0,+))")
                    .foregroundColor( tacklesArray[0...3].reduce(0,+) >= 8   ? .black : .red)
                    .padding()
                    .frame(width: 100, height: 45)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                    .padding(.horizontal)
                   
            }
        }
        Divider()
            .frame(maxWidth: .infinity, minHeight: 1)
            .overlay(.gray)
        
        
        
        .onAppear() {
            updateTacklesArrays()
        }
    }
      
    private func updateTacklesArrays() {
        // Tackles
        if tackles == "" {
            tackles = "0,0,0,0,0,0,0,0,0,0,0,0"
            tacklesArray = [0,0,0,0,0,0,0,0,0,0,0,0]
        } else {
            
            tacklesArray = tackles.components(separatedBy: ",").map { Int($0) ?? 0 }
        }
    }
}


struct QSTacklesView_Previews: PreviewProvider {
    static var previews: some View {
        QSTacklesView()
    }
}
