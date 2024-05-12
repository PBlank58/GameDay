//
//  HCMarksView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 18/9/2023.
//

import SwiftUI


struct HCMarksView: View {
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
    @State private var hcMarksArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @State private var hcMarksStringArray: [String] = []
    @AppStorage("hcmarks") var hcmarks = ""
    
 
    var body: some View {
        VStack {
            HStack {
         
                Text("\(matchViewModel.matchArray.count == 0 ? "Home" : matchViewModel.matchArray[0].homeAbbr) Marks")
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
                        .frame(width: 80,  height:35, alignment: .center)
                        .foregroundColor(CustomMag.HC_Mag)
                    Text("Mid")
                        .frame(width: 80,  height:35, alignment: .center)
                    Text("B40")
                        .frame(width: 80,  height:35, alignment: .center)
                        .foregroundColor(CustomMag.HC_Mag)
                }
                .font(.caption)
                HStack {
                    Text("C")
                        .frame(width: 40,  height:20, alignment: .center)
                        .foregroundColor(CustomMag.HC_Mag)
                    Text("NC")
                        .frame(width: 40,  height:20, alignment: .center)
                    Text("C")
                        .frame(width: 40,  height:20, alignment: .center)
                        .foregroundColor(CustomMag.HC_Mag)
                    Text("NC")
                        .frame(width: 40,  height:20, alignment: .center)
                    Text("C")
                        .frame(width: 40,  height:20, alignment: .center)
                        .foregroundColor(CustomMag.HC_Mag)
                    Text("NC")
                        .frame(width: 40,  height:20, alignment: .center)
                }
                .font(.caption)
                
                //button array
                VStack {
                  // 1st Quarter
                    if quarterInt == 1 || quarterInt == 5 {
                    HStack {
                        ButtonView(counter: $hcMarksArray[0], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[4], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[8], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[12], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[16], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[20], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                        }
                    }
                    else {
                    }
                    // 2nd Quarter
                    if quarterInt == 2 || quarterInt == 5 {
                      HStack {
                        ButtonView(counter: $hcMarksArray[1], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[5], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[9], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[13], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[17], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[21], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                      }
                  }
                  else {
                  }
                    if quarterInt == 3 || quarterInt == 5 {
                    // 3rd Quarter
                    HStack {
                        ButtonView(counter: $hcMarksArray[2], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[6], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[10], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[14], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[18], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[22], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                    }
                }
                else {
                }
                    if quarterInt == 4 || quarterInt == 5 {
                    //4th Quarter
                    HStack {
                        ButtonView(counter: $hcMarksArray[3], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[7], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[11], fColour: Color.black, bColour: Color.yellow, Opac: 0.625, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[15], fColour: Color.black, bColour: Color.yellow, Opac: 0.625, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[19], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                        ButtonView(counter: $hcMarksArray[23], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                    }
                }
                else {
                }
                    if quarterInt == 5 {
                   // Totals
                    HStack {
                        Text("\(hcMarksArray[0..<4].reduce(0,+))")
                            .font(.caption)
                            .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                            .frame(width:40 , height:35, alignment: .center)
                            .border(.gray)
                        Text("\(hcMarksArray[4..<8].reduce(0,+))")
                            .font(.caption)
                            .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                            .padding(.all)
                            .frame(width:40 , height:35, alignment: .center)
                          Text("\(hcMarksArray[8..<12].reduce(0,+))")
                              .font(.caption)
                              .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                              .padding(.all)
                              .frame(width:40 , height:35, alignment: .center)
                        Text("\(hcMarksArray[12..<16].reduce(0,+))")
                            .font(.caption)
                            .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                            .padding(.all)
                            .frame(width:40 , height:35, alignment: .center)
                        Text("\(hcMarksArray[16..<20].reduce(0,+))")
                            .font(.caption)
                            .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                            .padding(.all)
                            .frame(width:40 , height:35, alignment: .center)
                        Text("\(hcMarksArray[20..<24].reduce(0,+))")
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
                  updatehcMark()
                  updatehcMarkArray()
              }
              .onAppear() {
                  updatehcMarkArray()
              }
          }
        
          // convert integer array into string to save in AppStorage
          func updatehcMark() {
              
              hcMarksStringArray = hcMarksArray.map{String($0)}
             hcmarks = hcMarksStringArray.joined(separator: ",")
          }
          // convert AppStorage string into integer array and update Array
        func updatehcMarkArray() {
            if hcmarks == "" {
                hcmarks = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
                hcMarksArray  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
                
            } else {
                    hcMarksArray = hcmarks.components(separatedBy: ",").map { Int($0) ?? 0  }
                }
        }
      }

struct HCMarksView_Previews: PreviewProvider {
    static var previews: some View {
        HCMarksView(quarterInt: .constant(1))
    }
}
