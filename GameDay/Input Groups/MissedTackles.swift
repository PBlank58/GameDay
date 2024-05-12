//
//  MissedTackles.swift
//  GameDay
//
//  Created by Brett Pullyblank on 18/9/2023.
//

import SwiftUI

struct MissedTackles: View {
    
    @StateObject var matchViewModel = MatchViewModel()
   
    
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }
    
    
    @State var date = Date()
    //add Subtract bool
    @State var isAdd = true
    @Binding var quarterInt: Int
    
    // Covert string to array and back for AppStorage
    @State private var missedTackleArray: [Int]  = [0,0,0,0,0,0,0,0]
    @State private var missedTackleStringArray: [String] = []
    @AppStorage("missedtackle") var missedTackle = ""
    
    
    
    var body: some View {
        VStack {
            HStack {
                
                Text("Missed Tackles" )
                    .font(.subheadline)
                    .bold()
                Spacer()
                //toggle to add or subtract
                Button {
                    isAdd.toggle()
                } label: {
                    VStack {
                        Image(systemName:  isAdd ? "plus" : "minus")
                        
                    }
                    .frame(width: 20, height: 20)
                    
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 5,
                            style: .continuous
                        )
                        .fill(CustomMag.HC_Mag)
                        .opacity(0.6)
                    )
                    .overlay {
                        
                        RoundedRectangle(
                            cornerRadius: 5,
                            style: .continuous
                        )
                        .stroke(.gray, lineWidth: 2)
                    }
                }
                
                
            }
            
            VStack {
                
                HStack {
                    
                    Text("\(matchViewModel.matchArray.count == 0 ? "Home" : matchViewModel.matchArray[0].homeAbbr)")
                        .frame(width: 40,  height:35)
                        .foregroundColor(CustomMag.HC_Mag)
                    Text(matchViewModel.matchArray.count == 0 ? "Op" : matchViewModel.matchArray[0].oppAbbr)
                        .frame(width: 40,  height:35)
                    
                }
                .font(.caption)
                
                //button array
                VStack {
                    // 1st Quarter
                    if quarterInt == 1 || quarterInt == 5 {
                        HStack {
                        ButtonView(counter: $missedTackleArray[0], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                        ButtonView(counter: $missedTackleArray[4], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                        }
                    } else {
                    }
                    // 2nd Quarter
                    if quarterInt == 2 || quarterInt == 5 {
                        HStack {
                        ButtonView(counter: $missedTackleArray[1], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                        ButtonView(counter: $missedTackleArray[5], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                        }
                    } else {
                    }
                    // 3rd Quarter
                    if quarterInt == 3 || quarterInt == 5 {
                        HStack {
                        ButtonView(counter: $missedTackleArray[2], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                        ButtonView(counter: $missedTackleArray[6], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                        }
                    } else {
                    }
                    // 4th Quarter
                    if quarterInt == 4 || quarterInt == 5 {
                        HStack {
                        ButtonView(counter: $missedTackleArray[3], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                        ButtonView(counter: $missedTackleArray[7], fColour: Color.black, bColour: Color.yellow, Opac: 0.625, isAdd: $isAdd)
                                .frame(width:50 , height:35)
                        }
                    } else {
                    }
                    // Totals
                    if quarterInt == 5 {
                        HStack {
                         Text("\(missedTackleArray[0..<4].reduce(0,+))")
                             .font(.caption)
                             .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                             .padding(.all)
                             .frame(width:50 , height:35)
                        Text("\(missedTackleArray[4..<8].reduce(0,+))")
                            .font(.caption)
                            .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                        
                            .padding(.all)
                            .frame(width:40 , height:35)
                            .frame(width:40 , height:35)
                    }
                    .font(.caption)
                } else {
                    }
                    
                }
            }
        }
    
        .padding()
     
        .border(CustomMag.HC_Mag)
        .padding()
        
        .onDisappear() {
            updateMissTackle()
        }
        .onAppear() {
            updateMissTackleArray()
        }
    }
  
    // convert integer array into string to save in AppStorage
    func updateMissTackle() {
        
        missedTackleStringArray = missedTackleArray.map{String($0)}
        missedTackle = missedTackleStringArray.joined(separator: ",")
         
      //    print(missedTackleStringArray)
     //   print(missedTackle)

    }
    // convert AppStorage string into integer array and update Array
  func updateMissTackleArray() {
      if missedTackle == "" {
        missedTackle = "0,0,0,0,0,0,0,0"
        missedTackleArray = [0,0,0,0,0,0,0,0]
      } else {
              missedTackleArray = missedTackle.components(separatedBy: ",").map { Int($0) ?? 0  }
          }
    }
}

struct MissedTackles_Previews: PreviewProvider {
    static var previews: some View {
        MissedTackles(quarterInt: .constant(5))
    }
}
