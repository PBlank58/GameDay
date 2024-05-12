//
//  HCPossChainView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 8/1/2024.
//

import SwiftUI

struct PossChainView: View {
    
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
           @State private var ChainArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
           @State private var ChainStringArray: [String] = []
           @AppStorage("chain") var chain = ""
           
        
           
           
           var body: some View {
               VStack {
                   HStack {
                       Text("\(matchViewModel.matchArray.count != 0 ? matchViewModel.matchArray[0].oppAbbr : "Op")  Chain")
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
                           Text("Def 40")
                               .frame(width: 80,  height:35, alignment: .center)
                               .foregroundColor(CustomMag.HC_Mag)
                           Text("Mid")
                               .frame(width: 80,  height:35, alignment: .center)
                         
                       }
                       .font(.caption)
                       HStack {
                           Text("gain")
                               .frame(width: 40,  height:20, alignment: .center)
                               .foregroundColor(CustomMag.HC_Mag)
                           Text("✘")
                               .frame(width: 40,  height:20, alignment: .center)
                           Text("gain")
                               .frame(width: 40,  height:20, alignment: .center)
                               .foregroundColor(CustomMag.HC_Mag)
                           Text("✘")
                               .frame(width: 40,  height:20, alignment: .center)
                         
                       }
                       .font(.caption)
                       
                       //button array
                                     VStack {
                                       // 1st Quarter
                                         if quarterInt == 1 || quarterInt == 5 {
                                         HStack {
                                             ButtonView(counter: $ChainArray[0], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                                             ButtonView(counter: $ChainArray[4], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                                             ButtonView(counter: $ChainArray[8], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                                             ButtonView(counter: $ChainArray[12], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                                             }
                                         }
                                         else {
                                         }
                                         // 2nd Quarter
                                         if quarterInt == 2 || quarterInt == 5 {
                                           HStack {
                                             ButtonView(counter: $ChainArray[1], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                                             ButtonView(counter: $ChainArray[5], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                                             ButtonView(counter: $ChainArray[9], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                                             ButtonView(counter: $ChainArray[13], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                                           }
                                       }
                                       else {
                                       }
                                         if quarterInt == 3 || quarterInt == 5 {
                                         // 3rd Quarter
                                         HStack {
                                             ButtonView(counter: $ChainArray[2], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                                             ButtonView(counter: $ChainArray[6], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                                             ButtonView(counter: $ChainArray[10], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                                             ButtonView(counter: $ChainArray[14], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                                         }
                                     }
                                     else {
                                     }
                                         if quarterInt == 4 || quarterInt == 5 {
                                         //4th Quarter
                                         HStack {
                                             ButtonView(counter: $ChainArray[3], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                                             ButtonView(counter: $ChainArray[7], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                                             ButtonView(counter: $ChainArray[11], fColour: Color.black, bColour: Color.yellow, Opac: 0.625, isAdd: $isAdd)
                                             ButtonView(counter: $ChainArray[15], fColour: Color.black, bColour: Color.yellow, Opac: 0.625, isAdd: $isAdd)
                                         }
                                     }
                                     else {
                                     }
                                         if quarterInt == 5 {
                                        // Totals
                                         HStack {
                                             Text("\(ChainArray[0..<4].reduce(0,+))")
                                                 .font(.caption)
                                                 .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                                 .frame(width:40 , height:35, alignment: .center)
                                                 .border(.gray)
                                             Text("\(ChainArray[4..<8].reduce(0,+))")
                                                 .font(.caption)
                                                 .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                                 .padding(.all)
                                                 .frame(width:40 , height:35, alignment: .center)
                                               Text("\(ChainArray[8..<12].reduce(0,+))")
                                                   .font(.caption)
                                                   .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                                   .padding(.all)
                                                   .frame(width:40 , height:35, alignment: .center)
                                             Text("\(ChainArray[12..<16].reduce(0,+))")
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
                         updateChain()
                     }
                     .onAppear() {
                         updateChainArray()
                     }
                 }
               
                 // convert integer array into string to save in AppStorage
                 func updateChain() {
                     
                     ChainStringArray = ChainArray.map{String($0)}
                     chain = ChainStringArray.joined(separator: ",")
                 }
                 // convert AppStorage string into integer array and update Array
               func updateChainArray() {
                   if  chain == "" {
                       chain = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
                       ChainArray  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
                       
                   } else {
                       ChainArray = chain.components(separatedBy: ",").map { Int($0) ?? 0  }
                       }
               }
             }


#Preview {
    PossChainView(quarterInt: .constant(1))
}
