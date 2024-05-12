//
//  ClearancesView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 18/9/2023.
//

import SwiftUI

struct ClearancesView: View {
    
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
    
    @State var clearanceBool = false
    @Binding var quarterInt: Int
    
    // Covert string to array and back for AppStorage
    @State var clearanceArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @State private var clearanceStringArray: [String] = []
    @AppStorage("clearance") var clearance = ""
    
    
    var body: some View {
        VStack {
            HStack {
                      Text("Stoppages")
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
                    Text("\(matchViewModel.matchArray.count == 0 ? "Home" : matchViewModel.matchArray[0].homeAbbr) Centre")
                        .frame(width: 50,  height:35, alignment: .center)
                        .foregroundColor(CustomMag.HC_Mag)
                    Text("\(matchViewModel.matchArray.count == 0 ? "Home" : matchViewModel.matchArray[0].homeAbbr) Other")
                        .frame(width: 50,  height:35, alignment: .center)
                        .foregroundColor(CustomMag.HC_Mag)
                    Text("\(matchViewModel.matchArray.count == 0 ? "Op" : matchViewModel.matchArray[0].oppAbbr) Centre")
                        .frame(width: 50,  height:35, alignment: .center)
                    Text("\(matchViewModel.matchArray.count == 0 ? "Op" : matchViewModel.matchArray[0].oppAbbr) Other")
                        .frame(width: 50,  height:35, alignment: .center)
                      
                
                  
                }
                .font(.caption)
                
                //button array
                  VStack {
                      // 1st Quarter
                      if quarterInt == 1 || quarterInt == 5 {
                          HStack {
                              ButtonView(counter: $clearanceArray[0], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                              ButtonView(counter: $clearanceArray[4], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                              ButtonView(counter: $clearanceArray[8], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                              ButtonView(counter: $clearanceArray[12], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                          }
                      } else {
                          }
                      // 2nd Quarter
                      if quarterInt == 2 || quarterInt == 5 {
                          HStack {
                          ButtonView(counter: $clearanceArray[1], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                          ButtonView(counter: $clearanceArray[5], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                          ButtonView(counter: $clearanceArray[9], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                          ButtonView(counter: $clearanceArray[13], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                      }
                  } else {
                      }
                      // 3rd Quarter
                      if quarterInt == 3 || quarterInt == 5 {
                          HStack {
                          ButtonView(counter: $clearanceArray[2], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                          ButtonView(counter: $clearanceArray[6], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                          ButtonView(counter: $clearanceArray[10], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                          ButtonView(counter: $clearanceArray[14], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                      }
                  } else {
                      }
                      // 4th Quarter
                      if quarterInt == 4 || quarterInt == 5 {
                          HStack {
                          ButtonView(counter: $clearanceArray[3], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                          ButtonView(counter: $clearanceArray[7], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                          ButtonView(counter: $clearanceArray[11], fColour: Color.black, bColour: Color.yellow, Opac: 0.625, isAdd: $isAdd)
                          ButtonView(counter: $clearanceArray[15], fColour: Color.black, bColour: Color.yellow, Opac: 0.625, isAdd: $isAdd)
                      }
                  } else {
                      }
                      // Totals
                      if quarterInt == 5 {
                          HStack {
                          Text("\(clearanceArray[0..<4].reduce(0,+))")
                              .font(.caption)
                              .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                              .padding(.all)
                              .frame(width:40 , height:35)
                          Text("\(clearanceArray[4..<8].reduce(0,+))")
                              .font(.caption)
                              .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                              .padding(.all)
                              .frame(width:40 , height:35)
                          Text("\(clearanceArray[8..<12].reduce(0,+))")
                              .font(.caption)
                              .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                              .padding(.all)
                              .frame(width:40 , height:35)
                          Text("\(clearanceArray[12..<16].reduce(0,+))")
                              .font(.caption)
                              .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                              .padding(.all)
                              .frame(width:40 , height:35)
                      }
                  } else {
                      }
                      
                  }
              }
            
            
          }
          .padding()
          
              .border(CustomMag.HC_Mag)
              .padding()
        
        
              .onDisappear() {
                  updateClearance()
              }
             .onAppear() {
                 updateClearanceArray()
             }
      }
    // convert integer array into string to save in AppStorage
    func updateClearance() {
        
        clearanceStringArray = clearanceArray.map{String($0)}
        clearance = clearanceStringArray.joined(separator: ",")
    }
    // convert AppStorage string into integer array and update Array
  func updateClearanceArray() {
      if clearance == "" {
          clearance = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
          clearanceArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
      } else {
        
          clearanceArray = clearance.components(separatedBy: ",").map { Int($0) ?? 0 }
      }
    }
    
    func clearanceReset() {
        withAnimation(.spring()) {
        clearance = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
    clearanceArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
     
           
        }
    }
    
  }

struct ClearancesView_Previews: PreviewProvider {
    static var previews: some View {
        ClearancesView(quarterInt: .constant(1))
    }
}


