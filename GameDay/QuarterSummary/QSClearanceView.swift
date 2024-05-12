//
//  QSClearanceView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 20/9/2023.
//

import SwiftUI

struct QSClearanceView: View {
   
        //Custom Colours
        struct CustomGold {
            static let HC_Gold = Color("HC_Gold")
        }
        struct CustomMag {
            static let HC_Mag = Color("HC_Magenta")
        }
        
        @State var clearanceArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        @AppStorage("clearance") var clearance = ""
        
        var body: some View {
            HStack {
                Group {
                    Text("Centre Clearance")
                        .padding()
                        .frame(width: 260, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.3))
                        .padding(.horizontal)
                    // First Quarter
                    Text("\(clearanceArray[0]-clearanceArray[8])")
                        .foregroundColor(clearanceArray[0]-clearanceArray[8] >= 0 ? .black : .red)
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                    // Second Quarter
                    Text("\(clearanceArray[1]-clearanceArray[9])")
                        .foregroundColor(clearanceArray[1]-clearanceArray[9] >= 0 ? .black : .red)
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    // Third Quarter
                    Text("\(clearanceArray[2]-clearanceArray[10])")
                        .foregroundColor(clearanceArray[2]-clearanceArray[10] >= 0 ? .black : .red)
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                       
                    // Fourth Quarter
                    Text("\(clearanceArray[3]-clearanceArray[11])")
                        .foregroundColor(clearanceArray[3] - clearanceArray[11] >= 0 ? .black : .red)
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    //Totals
                    Text("\(clearanceArray[0...3].reduce(0,+) - clearanceArray[8...11].reduce(0,+))")
                        .foregroundColor(clearanceArray[0...3].reduce(0,+) - clearanceArray[8...11].reduce(0,+) >= 0 ? .black : .red)
                        .padding()
                        .frame(width: 100, height: 45)
                        .background(CustomMag.HC_Mag.opacity(0.1))
                        .border(.gray)
                        .padding(.horizontal)
                }
                .font(.title3)
            }
        HStack {
            Group {
                Text("Other Clearance")
                    .padding()
                    .frame(width: 260, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.3))
                    .padding(.horizontal)
                // First Quarter
                Text("\(clearanceArray[4]-clearanceArray[12])")
                    .foregroundColor(clearanceArray[4]-clearanceArray[12] >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                // Second Quarter
                Text("\(clearanceArray[5]-clearanceArray[13])")
                    .foregroundColor(clearanceArray[5]-clearanceArray[13] >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                // Third Quarter
                Text("\(clearanceArray[6]-clearanceArray[14])")
                    .foregroundColor(clearanceArray[6]-clearanceArray[14] >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    
                // Fourth Quarter
                Text("\(clearanceArray[7]-clearanceArray[15])")
                    .foregroundColor(clearanceArray[7] - clearanceArray[15] >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .background(.gray.opacity(0.1))
                //Totals
                Text("\(clearanceArray[4...7].reduce(0,+) - clearanceArray[12...15].reduce(0,+))")
                    .foregroundColor(clearanceArray[4...7].reduce(0,+) - clearanceArray[12...15].reduce(0,+) >= 0 ? .black : .red)
                    .padding()
                    .frame(width: 100, height: 45)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                    .padding(.horizontal)
            }
        }
        .font(.title3)
            
        .onAppear() {
            updateClearanceArrays()
        }
    }

   func updateClearanceArrays() {
       // Clearance
       if clearance == "" {
           clearance = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
           clearanceArray  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
       } else {
           clearanceArray = clearance.components(separatedBy: ",").map { Int($0) ?? 0 }
            }
        }
    }


struct QSClearanceView_Previews: PreviewProvider {
    static var previews: some View {
        QSClearanceView()
    }
}
