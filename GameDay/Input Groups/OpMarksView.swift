//
//  OpMarks.swift
//  GameDay
//
//  Created by Brett Pullyblank on 18/9/2023.
//


import SwiftUI

struct OpMarksView: View {
    
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
    @State private var opMarksArray: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @State private var opMarksStringArray: [String] = []
    @AppStorage("opmarks") var opmarks = ""
    
    
    var body: some View {
        VStack {
            HStack {
              
                Text("\(matchViewModel.matchArray.count  == 0 ? "Op" : matchViewModel.matchArray[0].opponent) Marks")
              
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
                
              // button array
                VStack {
                  // 1st Quarter
                    if quarterInt == 1 || quarterInt == 5 {
                    HStack {
                        ButtonView(counter: $opMarksArray[0], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[4], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[8], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[12], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[16], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[20], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                        }
                    }
                    else {
                    }
                    // 2nd Quarter
                    if quarterInt == 2 || quarterInt == 5 {
                      HStack {
                        ButtonView(counter: $opMarksArray[1], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[5], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[9], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[13], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[17], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[21], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                      }
                  }
                  else {
                  }
                    if quarterInt == 3 || quarterInt == 5 {
                    // 3rd Quarter
                    HStack {
                        ButtonView(counter: $opMarksArray[2], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[6], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[10], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[14], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[18], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[22], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                    }
                }
                else {
                }
                    if quarterInt == 4 || quarterInt == 5 {
                    //4th Quarter
                    HStack {
                        ButtonView(counter: $opMarksArray[3], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[7], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[11], fColour: Color.black, bColour: Color.yellow, Opac: 0.625, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[15], fColour: Color.black, bColour: Color.yellow, Opac: 0.625, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[19], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                        ButtonView(counter: $opMarksArray[23], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                    }
                }
                else {
                }
                    if quarterInt == 5 {
                   // Totals
                    HStack {
                        Text("\(opMarksArray[0..<4].reduce(0,+))")
                            .font(.caption)
                            .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                            .frame(width:40 , height:35, alignment: .center)
                            .border(.gray)
                        Text("\(opMarksArray[4..<8].reduce(0,+))")
                            .font(.caption)
                            .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                            .padding(.all)
                            .frame(width:40 , height:35, alignment: .center)
                          Text("\(opMarksArray[8..<12].reduce(0,+))")
                              .font(.caption)
                              .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                              .padding(.all)
                              .frame(width:40 , height:35, alignment: .center)
                        Text("\(opMarksArray[12..<16].reduce(0,+))")
                            .font(.caption)
                            .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                            .padding(.all)
                            .frame(width:40 , height:35, alignment: .center)
                        Text("\(opMarksArray[16..<20].reduce(0,+))")
                            .font(.caption)
                            .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                            .padding(.all)
                            .frame(width:40 , height:35, alignment: .center)
                        Text("\(opMarksArray[20..<24].reduce(0,+))")
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
                  updateopMark()
              }
              .onAppear() {
                  updateopMarkArray()
              }
          }
        
          // convert integer array into string to save in AppStorage
          func updateopMark() {
              
              opMarksStringArray = opMarksArray.map{String($0)}
             opmarks = opMarksStringArray.joined(separator: ",")
          }
          // convert AppStorage string into integer array and update Array
        func updateopMarkArray() {
            if opmarks == "" {
                opmarks = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
                opMarksArray = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
            } else {
                    opMarksArray = opmarks.components(separatedBy: ",").map { Int($0) ?? 0  }
                }
        }
      }

struct OpMarksView_Previews: PreviewProvider {
    static var previews: some View {
        OpMarksView(quarterInt: .constant(1))
    }
}
