//
//  PressureView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 19/9/2023.
//

import SwiftUI

struct PressureView: View {
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
        @State private var pressureArray: [Int]  = [0,0,0,0,0,0,0,0]
        @State private var pressureStringArray: [String] = []
        @AppStorage("pressure") var pressure = ""
       
        var body: some View {
            VStack {
                HStack {
                    
                    Text("Pressure" )
                  
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
                        VStack {
                            Text("Non Con")
                            Text("Gain")
                        }
                            .frame(width: 60,  height:35, alignment: .center)
                            .foregroundColor(CustomMag.HC_Mag)
                        VStack {
                            Text("Down")
                              Text("T line")
                        }
                        .frame(width: 40,  height:35)
                    }
                    .font(.caption)
                    
                    //button array
                      VStack {
                          // 1st Quarter
                            if quarterInt == 1 || quarterInt == 5 {
                            HStack {
                              ButtonView(counter: $pressureArray[0], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                              ButtonView(counter: $pressureArray[4], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                            }
                        }
                        else {
                        }
                        // 2nd Quarter
                        if quarterInt == 2 || quarterInt == 5 {
                          HStack {
                              ButtonView(counter: $pressureArray[1], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                              ButtonView(counter: $pressureArray[5], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                          }
                      }
                      else {
                      }
                        if quarterInt == 3 || quarterInt == 5 {
                        // 3rd Quarter
                        HStack {
                              ButtonView(counter: $pressureArray[2], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                              ButtonView(counter: $pressureArray[6], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                        }
                    }
                    else {
                    }
                        if quarterInt == 4 || quarterInt == 5 {
                        //4th Quarter
                        HStack {
                              ButtonView(counter: $pressureArray[3], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                              ButtonView(counter: $pressureArray[7], fColour: Color.black, bColour: Color.yellow, Opac: 0.625, isAdd: $isAdd)
                        }
                    }
                    else {
                    }
                        if quarterInt == 5 {
                       // Totals
                        HStack {
                              Text("\(pressureArray[0..<4].reduce(0,+))")
                                  .font(.caption)
                                  .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                  .padding(.all)
                                  .frame(width:50 , height:35)
                              Text("\(pressureArray[4..<8].reduce(0,+))")
                                  .font(.caption)
                                  .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                              
                                  .padding(.all)
                                  .frame(width:40 , height:35)
                        }
                    }
                    else {
                    }
                           
                      }
                  }
              
              }
              .padding()
             
                  .border(CustomMag.HC_Mag)
                  .padding()
          
                  .onDisappear() {
                      updateContested()
                  }
                 .onAppear() {
                     updateContestedArray()
                 }
          }
    // convert integer array into string to save in AppStorage
    func updateContested() {
        
        pressureStringArray = pressureArray.map{String($0)}
        pressure = pressureStringArray.joined(separator: ",")
         
     
    }
    // convert AppStorage string into integer array and update Array
    func updateContestedArray() {
      if pressure == "" {
          pressure = "0,0,0,0,0,0,0,0"
          pressureArray  = [0,0,0,0,0,0,0,0]
      } else {
        
          pressureArray = pressure.components(separatedBy: ",").map { Int($0) ?? 0 }
            }
        }
      }


struct PressureView_Previews: PreviewProvider {
    static var previews: some View {
        PressureView(quarterInt: .constant(1))
    }
}
