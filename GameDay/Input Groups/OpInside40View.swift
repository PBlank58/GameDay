//
//  OpInside40View.swift
//  GameDay
//
//  Created by Brett Pullyblank on 19/9/2023.
//

import SwiftUI

struct OpInside40View: View {
   
            //Custom Colours
            struct CustomGold {
                static let HC_Gold = Color("HC_Gold")
            }
            struct CustomMag {
                static let HC_Mag = Color("HC_Magenta")
            }
            @StateObject var matchViewModel = MatchViewModel()
            //add Subtract bool
            @State var isAdd = true
            @Binding var quarterInt: Int
           
            
        // Covert string to array and back for AppStorage
        @State var opInside40Array: [Int]  = [0,0,0,0,0,0,0,0]
        @State private var opInside40StringArray: [String] = []
        @AppStorage("opInside40") var opInside40 = ""
            
            
            var body: some View {
                VStack {
                    HStack {
                      
                        Text("\(matchViewModel.matchArray.count == 0 ? "Op" : matchViewModel.matchArray[0].oppAbbr  ) Inside 40")
                      
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
                            Text("deep")
                                .frame(width: 40,  height:35)
                                .foregroundColor(CustomMag.HC_Mag)
                           
                            Text("shall")
                                .frame(width: 40,  height:35)
                                .foregroundColor(CustomMag.HC_Mag)
                            Text("T")
                                .frame(width: 40,  height:35)
                              
                        
                          
                        }
                        .font(.caption)
                        
                        //button array
                          VStack {
                              // 1st Quarter
                                if quarterInt == 1 || quarterInt == 5 {
                                HStack {
                                  ButtonView(counter: $opInside40Array[0], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                                  ButtonView(counter: $opInside40Array[4], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                                  Text("\(opInside40Array[0] + opInside40Array[4] )")
                                       .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                       .padding(.all)
                                       .frame(width:50 , height:35)
                                }
                            }
                           
                            // 2nd Quarter
                            if quarterInt == 2 || quarterInt == 5 {
                              HStack {
                                  ButtonView(counter: $opInside40Array[1], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                                  ButtonView(counter: $opInside40Array[5], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                                  Text("\(opInside40Array[1] + opInside40Array[5] )")
                                      .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                      .padding(.all)
                                      .frame(width:50 , height:35)
                              }
                          }
                          
                            if quarterInt == 3 || quarterInt == 5 {
                            // 3rd Quarter
                            HStack {
                                  ButtonView(counter: $opInside40Array[2], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                                  ButtonView(counter: $opInside40Array[6], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                                  Text("\(opInside40Array[2] + opInside40Array[6] )")
                                      .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                      .padding(.all)
                                      .frame(width:50 , height:35)
                            }
                        }
                        
                            if quarterInt == 4 || quarterInt == 5 {
                            //4th Quarter
                            HStack {
                                  ButtonView(counter: $opInside40Array[3], fColour: Color.black, bColour: Color.yellow, Opac: 0.725, isAdd: $isAdd)
                                  ButtonView(counter: $opInside40Array[7], fColour: Color.black, bColour: Color.yellow, Opac: 0.725, isAdd: $isAdd)
                                  Text("\(opInside40Array[3] + opInside40Array[7])")
                                      .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                      .padding(.all)
                                      .frame(width:50 , height:35)
                            }
                        }
                       
                            if quarterInt == 5 {
                           // Totals
                            HStack {
                                  Text("\(opInside40Array[0..<4].reduce(0,+))")
                                      .font(.caption)
                                      .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                      .padding(.all)
                                      .frame(width:40 , height:35)
                                  Text("\(opInside40Array[4..<8].reduce(0,+))")
                                      .font(.caption)
                                      .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                      .padding(.all)
                                      .frame(width:40 , height:35)
                                  Text("\(opInside40Array[0..<4].reduce(0,+) + opInside40Array[4..<8].reduce(0,+) )")
                                      .frame(width: 50, height: 35)
                                      .foregroundColor(CustomMag.HC_Mag.opacity(1.0))
                                      .padding(.all)
                            }
                        }
                       
            
                             
                          }
                      }
                  
                  }
                  .padding()
                 
                      .border(CustomMag.HC_Mag)
                      .padding()
                
                      .onDisappear() {
                          updateTackle()
                      }
                     .onAppear() {
                         updateTackleArray()
                     }
              }
        // convert integer array into string to save in AppStorage
        func updateTackle() {
            
            opInside40StringArray = opInside40Array.map{String($0)}
            opInside40 = opInside40StringArray.joined(separator: ",")
             
         
        }
        // convert AppStorage string into integer array and update Array
      func updateTackleArray() {
          if opInside40 == "" {
              opInside40 = "0,0,0,0,0,0,0,0"
              opInside40Array = [0,0,0,0,0,0,0,0]
          } else {
            
              opInside40Array = opInside40.components(separatedBy: ",").map { Int($0) ?? 0 }
                    }
                }
          }

struct OpInside40View_Previews: PreviewProvider {
    static var previews: some View {
        OpInside40View(quarterInt: .constant(1))
    }
}
