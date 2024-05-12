//
//  TacklesView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 18/9/2023.
//

import SwiftUI

struct TacklesView: View {
        //Custom Colours
        struct CustomGold {
            static let HC_Gold = Color("HC_Gold")
        }
        struct CustomMag {
            static let HC_Mag = Color("HC_Magenta")
        }
        
        //add Subtract bool
        @State var isAdd = true
        @Binding var quarterInt: Int
        
    // Covert string to array and back for AppStorage
    @State var tacklesArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0]
    @State private var tacklesStringArray: [String] = []
    @AppStorage("tackles") var tackles = ""
        
        
        var body: some View {
            VStack {
                HStack {
                  
                    Text("Tackles")
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
                        Text("F40")
                            .frame(width: 40,  height:35)
                            .foregroundColor(CustomMag.HC_Mag)
                        Text("Mid")
                            .frame(width: 40,  height:35)
                        Text("B40")
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
                                ButtonView(counter: $tacklesArray[0], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                                ButtonView(counter: $tacklesArray[4], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                                ButtonView(counter: $tacklesArray[8], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                                Text("\(tacklesArray[0] + tacklesArray[4] + tacklesArray[8])")
                                    .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                    .padding(.all)
                                    .frame(width:50 , height:35)
                            }
                        }
                       
                        // 2nd Quarter
                        if quarterInt == 2 || quarterInt == 5 {
                            HStack {
                                ButtonView(counter: $tacklesArray[1], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                                ButtonView(counter: $tacklesArray[5], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                                ButtonView(counter: $tacklesArray[9], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                                Text("\(tacklesArray[1] + tacklesArray[5] + tacklesArray[9])")
                                    .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                    .padding(.all)
                                    .frame(width:50 , height:35)
                            }
                        }
                        // 3rd Quarter
                            if quarterInt == 3 || quarterInt == 5 {
                                HStack {
                                    ButtonView(counter: $tacklesArray[2], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                                    ButtonView(counter: $tacklesArray[6], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                                    ButtonView(counter: $tacklesArray[10], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                                    Text("\(tacklesArray[2] + tacklesArray[6] + tacklesArray[10])")
                                        .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                        .padding(.all)
                                        .frame(width:50 , height:35)
                                }
                            }
                        // 4th Quarter
                        if quarterInt == 4 || quarterInt == 5 {
                            HStack {
                                ButtonView(counter: $tacklesArray[3], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                                ButtonView(counter: $tacklesArray[7], fColour: Color.black, bColour: Color.yellow, Opac: 0.625, isAdd: $isAdd)
                                ButtonView(counter: $tacklesArray[11], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                                Text("\(tacklesArray[3] + tacklesArray[7] + tacklesArray[11])")
                                    .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                    .padding(.all)
                                    .frame(width:50 , height:35)
                            }
                        
                        }
                        // Totals
                        if quarterInt == 5 {
                            HStack {
                            Text("\(tacklesArray[0..<4].reduce(0,+))")
                                .font(.caption)
                                .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                .padding(.all)
                                .frame(width:40 , height:35)
                            Text("\(tacklesArray[4..<8].reduce(0,+))")
                                .font(.caption)
                                .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                .padding(.all)
                                .frame(width:40 , height:35)
                            Text("\(tacklesArray[8..<12].reduce(0,+))")
                                .font(.caption)
                                .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                .padding(.all)
                                .frame(width:40 , height:35)
                           Text("\(tacklesArray[0..<12].reduce(0,+) )")
                                .foregroundColor(CustomMag.HC_Mag.opacity(1.0))
                                .padding(.all)
                                .frame(width:50 , height:35)
                            }
                            .font(.caption)
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
        tacklesStringArray = tacklesArray.map{String($0)}
        tackles = tacklesStringArray.joined(separator: ",")
         
    }
    // convert AppStorage string into integer array and update Array
  func updateTackleArray() {
      if tackles == "" {
          tackles = "0,0,0,0,0,0,0,0,0,0,0,0"
          tacklesArray = [0,0,0,0,0,0,0,0,0,0,0,0]
      } else {
        
          tacklesArray = tackles.components(separatedBy: ",").map { Int($0) ?? 0 }
      }
    }
      }

struct TacklesView_Previews: PreviewProvider {
    static var previews: some View {
        TacklesView(quarterInt: .constant(1))
    }
}
