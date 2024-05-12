//
//  HCInside40View.swift
//  GameDay
//
//  Created by Brett Pullyblank on 19/9/2023.
//

import SwiftUI

struct HCInside40View: View {
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
    @State var hcInside40Array: [Int]  = [0,0,0,0,0,0,0,0]
    @State private var hcInside40StringArray: [String] = []
    @AppStorage("hcInside40") var hcInside40 = ""
    @StateObject var matchViewModel = MatchViewModel()
 
    
        var body: some View {
            VStack {
                HStack {
                  
                    Text("\(matchViewModel.matchArray.count == 0 ? "Home" : matchViewModel.matchArray[0].homeAbbr) Inside 40")
                  
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
                              ButtonView(counter: $hcInside40Array[0], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                              ButtonView(counter: $hcInside40Array[4], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                              Text("\(hcInside40Array[0] + hcInside40Array[4] )")
                                   .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                   .padding(.all)
                                   .frame(width:50 , height:35)
                            }
                        }
                       
                        // 2nd Quarter
                        if quarterInt == 2 || quarterInt == 5 {
                          HStack {
                              ButtonView(counter: $hcInside40Array[1], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                              ButtonView(counter: $hcInside40Array[5], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                              Text("\(hcInside40Array[1] + hcInside40Array[5] )")
                                  .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                  .padding(.all)
                                  .frame(width:50 , height:35)
                          }
                      }
                      
                        if quarterInt == 3 || quarterInt == 5 {
                        // 3rd Quarter
                        HStack {
                              ButtonView(counter: $hcInside40Array[2], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                              ButtonView(counter: $hcInside40Array[6], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                              Text("\(hcInside40Array[2] + hcInside40Array[6] )")
                                  .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                  .padding(.all)
                                  .frame(width:50 , height:35)
                        }
                    }
                   
                        if quarterInt == 4 || quarterInt == 5 {
                        //4th Quarter
                        HStack {
                              ButtonView(counter: $hcInside40Array[3], fColour: Color.black, bColour: Color.yellow, Opac: 0.725, isAdd: $isAdd)
                              ButtonView(counter: $hcInside40Array[7], fColour: Color.black, bColour: Color.yellow, Opac: 0.725, isAdd: $isAdd)
                              Text("\(hcInside40Array[3] + hcInside40Array[7])")
                                  .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                  .padding(.all)
                                  .frame(width:50 , height:35)
                        }
                    }
                    
                        if quarterInt == 5 {
                       // Totals
                        HStack {
                              Text("\(hcInside40Array[0..<4].reduce(0,+))")
                                  .font(.caption)
                                  .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                  .padding(.all)
                                  .frame(width:40 , height:35)
                              Text("\(hcInside40Array[4..<8].reduce(0,+))")
                                  .font(.caption)
                                  .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                  .padding(.all)
                                  .frame(width:40 , height:35)
                              Text("\(hcInside40Array[0..<4].reduce(0,+) + hcInside40Array[4..<8].reduce(0,+) )")
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
        
        hcInside40StringArray = hcInside40Array.map{String($0)}
        hcInside40 = hcInside40StringArray.joined(separator: ",")
         
     
    }
    // convert AppStorage string into integer array and update Array
  func updateTackleArray() {
      if hcInside40 == "" {
          hcInside40 = "0,0,0,0,0,0,0,0"
          hcInside40Array = [0,0,0,0,0,0,0,0]
      } else {
        
          hcInside40Array = hcInside40.components(separatedBy: ",").map { Int($0) ?? 0 }
            }
        }
      }


struct HCInside40View_Previews: PreviewProvider {
    static var previews: some View {
        HCInside40View(quarterInt: .constant(1))
    }
}
