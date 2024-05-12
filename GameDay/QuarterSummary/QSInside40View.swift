//
//  QSInside40View.swift
//  GameDay
//
//  Created by Brett Pullyblank on 21/9/2023.
//

import SwiftUI

struct QSInside40View: View {
        //Custom Colours
        struct CustomGold {
            static let HC_Gold = Color("HC_Gold")
        }
        struct CustomMag {
            static let HC_Mag = Color("HC_Magenta")
        }
        
    @AppStorage("hcInside40") var hcInside40 = ""
    @State private var  hcInside40Array: [Int] = [0,0,0,0,0,0,0,0]
    
    @AppStorage("opInside40") var opInside40 = ""
    @State private var  opInside40Array: [Int] = [0,0,0,0,0,0,0,0]
   
 
        var body: some View {
            HStack {
                Group {
                    Text("Inside 40   Us")
                        .padding()
                        .frame(width: 260, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.3))
                        .padding(.horizontal)
                    // First Quarter
                    Text("\(hcInside40Array[0] + hcInside40Array[4] )")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                    // Second Quarter
                    Text("\(hcInside40Array[1] + hcInside40Array[5] )")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    // Third Quarter
                    Text("\(hcInside40Array[2] + hcInside40Array[6] )")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                     
                    // Fourth Quarter
                    Text("\(hcInside40Array[3] + hcInside40Array[7] )")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    //Totals
                    Text("\(hcInside40Array[0...7].reduce(0,+))")
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
                    Text("   -deep")
                        .padding()
                        .frame(width: 260 , height: 45, alignment: .trailing)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                        .padding(.horizontal)
                    // First Quarter
                    Text("\(hcInside40Array[0])")
                       
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                    // Second Quarter
                    Text("\(hcInside40Array[1])")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    // Third Quarter
                    Text("\(hcInside40Array[2])")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                       
                    // Fourth Quarter
                    Text("\(hcInside40Array[3])")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    //Totals
                    Text("\(hcInside40Array[4...7].reduce(0,+))")
                       
                        .padding()
                        .frame(width: 100, height: 45)
                        .background(CustomMag.HC_Mag.opacity(0.1))
                        .border(.gray)
                        .padding(.horizontal)
                       
                }
            }
            HStack {
                Group {
                    Text("Inside 40  Them")
                        .padding()
                        .frame(width: 260, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.3))
                        .padding(.horizontal)
                    // First Quarter
                    Text("\(opInside40Array[0] + opInside40Array[4] )")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                    // Second Quarter
                    Text("\(opInside40Array[1] + opInside40Array[5] )")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    // Third Quarter
                    Text("\(opInside40Array[2] + opInside40Array[6] )")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                     
                    // Fourth Quarter
                    Text("\(opInside40Array[3] + opInside40Array[7] )")
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    //Totals
                    Text("\(opInside40Array[0...7].reduce(0,+))")
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
                    Text("Inside 40 difference")
                        .padding()
                        .frame(width: 260, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.3))
                        .padding(.horizontal)
                    // First Quarter
                    Text("\((hcInside40Array[0] + hcInside40Array[4]) - (opInside40Array[0] + opInside40Array[4] ))")
                        .foregroundColor((hcInside40Array[0] + hcInside40Array[4]) - (opInside40Array[0] + opInside40Array[4] ) >= 0 ? .black : .red)
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                    // Second Quarter
                    Text("\((hcInside40Array[1] + hcInside40Array[5]) - (opInside40Array[1] + opInside40Array[5] ))")
                        .foregroundColor((hcInside40Array[1] + hcInside40Array[5]) - (opInside40Array[1] + opInside40Array[5] ) >= 0 ? .black : .red)
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    // Third Quarter
                    Text("\((hcInside40Array[2] + hcInside40Array[6]) - (opInside40Array[2] + opInside40Array[6] ))")
                        .foregroundColor((hcInside40Array[2] + hcInside40Array[6]) - (opInside40Array[2] + opInside40Array[6] ) >= 0 ? .black : .red)
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                     
                    // Fourth Quarter
                    Text("\((hcInside40Array[3] + hcInside40Array[7]) - (opInside40Array[3] + opInside40Array[7] ))")
                        .foregroundColor((hcInside40Array[3] + hcInside40Array[7]) - (opInside40Array[3] + opInside40Array[7] ) >= 0 ? .black : .red)
                        .padding()
                        .frame(width: 70, height: 45)
                        .border(.gray)
                        .background(.gray.opacity(0.1))
                    //Totals
                    Text("\(hcInside40Array[0...7].reduce(0,+) - opInside40Array[0...7].reduce(0,+))")
                        .foregroundColor(hcInside40Array[0...7] .reduce(0,+) - opInside40Array[0...7] .reduce(0,+) >= 0 ? .black : .red)
                        .padding()
                        .frame(width: 100, height: 45)
                        .background(CustomMag.HC_Mag.opacity(0.1))
                        .border(.gray)
                        .padding(.horizontal)
                       
                }
            }
            .font(.title3)
            .onAppear() {
                updateInside40Arrays()
            }
        }
      
          
    private func updateInside40Arrays() {
        // HcInside 40s
        if hcInside40 == "" {
            hcInside40 = "0,0,0,0,0,0,0,0"
            hcInside40Array = [0,0,0,0,0,0,0,0]
        } else {
            
            hcInside40Array = hcInside40.components(separatedBy: ",").map { Int($0) ?? 0 }
        }
        // OpInside 40s
        if opInside40 == "" {
            opInside40 = "0,0,0,0,0,0,0,0"
            opInside40Array = [0,0,0,0,0,0,0,0]
        } else {
            opInside40Array = opInside40.components(separatedBy: ",").map { Int($0) ?? 0 }
            }
        }
    }


struct QSInside40View_Previews: PreviewProvider {
    static var previews: some View {
        QSInside40View()
    }
}
