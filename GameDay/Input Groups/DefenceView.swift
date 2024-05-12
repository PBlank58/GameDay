//
//  DefenceMarkView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 16/4/2024.
//
//

import SwiftUI

struct DefenceView: View {
  
                @StateObject var matchViewModel = MatchViewModel()
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
               @State private var defenceArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0]
               @State private var defenceStringArray: [String] = []
               @AppStorage("defence") var defence = ""
               
            
               
               
               var body: some View {
                   VStack {
                       HStack {
                           Text("Defence" )
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
                           
                           
                           VStack {
                               HStack {
                                   Text("Mark from")
                                   Text("\(matchViewModel.matchArray.count == 0 ? "Op" : matchViewModel.matchArray[0].oppAbbr)")
                               }
                               .frame(width: 120,  height:20, alignment: .center)
                               .foregroundColor(CustomMag.HC_Mag)
                               HStack {
                                   Text("F40")
                                       .frame(width: 40,  height:20, alignment: .center)
                                   HStack {
                                       Text("Mid")
                                           .frame(width: 40,  height:20, alignment: .center)
                                           .foregroundColor(CustomMag.HC_Mag)
                                       
                                       Text("B40")
                                           .frame(width: 40,  height:20, alignment: .center)
                                   }
                               }
                           }
                           .font(.caption)
                           
                           //button array
                           VStack {
                              
                                   // 1st Quarter
                               if quarterInt == 1 || quarterInt == 5 {
                                   HStack  {
                                       ButtonView(counter: $defenceArray[0], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                                       ButtonView(counter: $defenceArray[4], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                                       ButtonView(counter: $defenceArray[8], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                                   }
                               }  else {
                                   }
                                   // 2nd Quarter
                               if quarterInt == 2 || quarterInt == 5 {
                                   HStack  {
                                       ButtonView(counter: $defenceArray[1], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                                       ButtonView(counter: $defenceArray[5], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                                       ButtonView(counter: $defenceArray[9], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                                       
                                   }
                               }  else {
                                   }
                               if quarterInt == 3 || quarterInt == 5 {
                                   // 3rd Quarter
                                   HStack  {
                                       ButtonView(counter: $defenceArray[2], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                                       ButtonView(counter: $defenceArray[6], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                                       ButtonView(counter: $defenceArray[10], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                                   }
                               }  else {
                                   }
                               if quarterInt == 4 || quarterInt == 5 {
                                   //4th Quarter
                                   HStack  {
                                       ButtonView(counter: $defenceArray[3], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                                       ButtonView(counter: $defenceArray[7], fColour: Color.black, bColour: Color.yellow, Opac: 0.625, isAdd: $isAdd)
                                       ButtonView(counter: $defenceArray[11], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                                       
                                   }
                               }  else {
                                   }
                               if quarterInt == 5 {
                                   // Totals
                                   HStack  {
                                       Text("\(defenceArray[0..<4].reduce(0,+))")
                                           .font(.caption)
                                           .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                           .frame(width:40 , height:35, alignment: .center)
                                           .border(.gray)
                                       Text("\(defenceArray[4..<8].reduce(0,+))")
                                           .font(.caption)
                                           .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                           .padding(.all)
                                           .frame(width:40 , height:35, alignment: .center)
                                       Text("\(defenceArray[9..<12].reduce(0,+))")
                                           .font(.caption)
                                           .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                           .padding(.all)
                                           .frame(width:40 , height:35, alignment: .center)
                                       
                                   }
                               }  else {
                                   }
                                  
                           }
                       }
                    }
                     .padding()
                    
                         .border(CustomMag.HC_Mag)
                         .padding()
                       
                         .onDisappear() {
                             updateDefence()
                         }
                         .onAppear() {
                             updateDefenceArray()
                         }
                     }
                   
                     // convert integer array into string to save in AppStorage
                     func updateDefence() {
                         
                         defenceStringArray = defenceArray.map{String($0)}
                         defence = defenceStringArray.joined(separator: ",")
                     }
                     // convert AppStorage string into integer array and update Array
                   func updateDefenceArray() {
                       if defence == "" {
                           defence = "0,0,0,0,0,0,0,0,0,0,0,0"
                           defenceArray  = [0,0,0,0,0,0,0,0,0,0,0,0]
                           
                       } else {
                           defenceArray = defence.components(separatedBy: ",").map { Int($0) ?? 0  }
                           }
                   }
                 }


struct DefenceView_Previews: PreviewProvider {
    static var previews: some View {
        DefenceView(quarterInt: .constant(1))
    }
}

