//
//  ExtraView2.swift
//  GameDay
//
//  Created by Brett Pullyblank on 31/10/2023.
//

import SwiftUI

struct ExtraView2: View {
  
        
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
           
           @State private var title: String = ""
           @State private var header1: String = ""
           @State private var header2: String = ""
           
          
             
              
               
               // Covert string to array and back for AppStorage
               @State private var extraArray2: [Int]  = [0,0,0,0,0,0,0,0]
               @State private var extraStringArray2: [String] = []
               @AppStorage("extra2") var extra2 = ""
               
            
               
               
               var body: some View {
                   VStack {
                       HStack {
                         TextField("Title2", text: $title)
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
                               TextField("1", text: $header1)
                                   .frame(width: 40,  height:20, alignment: .center)
                                   .foregroundColor(CustomMag.HC_Mag)
                               TextField("2", text: $header2)
                                   .frame(width: 40,  height:20, alignment: .center)
                               
                           }
                           .font(.caption)
                           
                           //button array
                                         VStack {
                                           // 1st Quarter
                                             if quarterInt == 1 || quarterInt == 5 {
                                             HStack {
                                                 ButtonView(counter: $extraArray2[0], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                                                 ButtonView(counter: $extraArray2[4], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                                                 }
                                             }
                                             else {
                                             }
                                             // 2nd Quarter
                                             if quarterInt == 2 || quarterInt == 5 {
                                               HStack {
                                                 ButtonView(counter: $extraArray2[1], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                                                 ButtonView(counter: $extraArray2[5], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                                               }
                                           }
                                           else {
                                           }
                                             if quarterInt == 3 || quarterInt == 5 {
                                             // 3rd Quarter
                                             HStack {
                                                 ButtonView(counter: $extraArray2[2], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                                                 ButtonView(counter: $extraArray2[6], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                                             }
                                         }
                                         else {
                                         }
                                             if quarterInt == 4 || quarterInt == 5 {
                                             //4th Quarter
                                             HStack {
                                                 ButtonView(counter: $extraArray2[3], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                                                 ButtonView(counter: $extraArray2[7], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                                             }
                                         }
                                         else {
                                         }
                                             if quarterInt == 5 {
                                            // Totals
                                             HStack {
                                                 Text("\(extraArray2[0..<4].reduce(0,+))")
                                                     .font(.caption)
                                                     .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                                     .frame(width:40 , height:35, alignment: .center)
                                                     .border(.gray)
                                                 Text("\(extraArray2[4..<8].reduce(0,+))")
                                                     .font(.caption)
                                                     .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                                     .padding(.all)
                                                     .frame(width:40 , height:35, alignment: .center)
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
                             updateExtra2()
                         }
                         .onAppear() {
                             updateExtra2Array()
                         }
                     }
                   
                     // convert integer array into string to save in AppStorage
                     func updateExtra2() {
                         
                         extraStringArray2 = extraArray2.map{String($0)}
                        extra2 = extraStringArray2.joined(separator: ",")
                     }
                     // convert AppStorage string into integer array and update Array
                   func updateExtra2Array() {
                       if extra2 == "" {
                           extra2 = "0,0,0,0,0,0,0,0"
                           extraArray2  = [0,0,0,0,0,0,0,0]
                           
                       } else {
                               extraArray2 = extra2.components(separatedBy: ",").map { Int($0) ?? 0  }
                           }
                   }
                 }


struct ExtraView2_Previews: PreviewProvider {
    static var previews: some View {
        ExtraView2(quarterInt: .constant(1))
    }
}
