//
//  ExtraView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 19/9/2023.
//

import SwiftUI

struct ExtraView6: View {
 
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
    @State private var header3: String = ""
    @State private var header4: String = ""
    @State private var header5: String = ""
    @State private var header6: String = ""
      
       
        
        // Covert string to array and back for AppStorage
        @State private var extraArray6: [Int]  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        @State private var extraStringArray6: [String] = []
        @AppStorage("extra6") var extra6 = ""
        
     
        
        
        var body: some View {
            VStack {
                HStack {
                  TextField("Title6", text: $title)
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
                        TextField("3", text: $header3)
                            .frame(width: 40,  height:20, alignment: .center)
                            .foregroundColor(CustomMag.HC_Mag)
                        TextField("4", text: $header4)
                            .frame(width: 40,  height:20, alignment: .center)
                        TextField("5", text: $header5)
                            .frame(width: 40,  height:20, alignment: .center)
                            .foregroundColor(CustomMag.HC_Mag)
                        TextField("6", text: $header6)
                            .frame(width: 40,  height:20, alignment: .center)
                    }
                    .font(.caption)
                    
                    //button array
                                  VStack {
                                    // 1st Quarter
                                      if quarterInt == 1 || quarterInt == 5 {
                                      HStack {
                                          ButtonView(counter: $extraArray6[0], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[4], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[8], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[12], fColour: Color.black, bColour: Color.yellow, Opac: 0.125, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[16], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[20], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.125, isAdd: $isAdd)
                                          }
                                      }
                                      else {
                                      }
                                      // 2nd Quarter
                                      if quarterInt == 2 || quarterInt == 5 {
                                        HStack {
                                          ButtonView(counter: $extraArray6[1], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[5], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[9], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[13], fColour: Color.black, bColour: Color.yellow, Opac: 0.25, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[17], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[21], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.25, isAdd: $isAdd)
                                        }
                                    }
                                    else {
                                    }
                                      if quarterInt == 3 || quarterInt == 5 {
                                      // 3rd Quarter
                                      HStack {
                                          ButtonView(counter: $extraArray6[2], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[6], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[10], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[14], fColour: Color.black, bColour: Color.yellow, Opac: 0.5, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[18], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[22], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.5, isAdd: $isAdd)
                                      }
                                  }
                                  else {
                                  }
                                      if quarterInt == 4 || quarterInt == 5 {
                                      //4th Quarter
                                      HStack {
                                          ButtonView(counter: $extraArray6[3], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[7], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[11], fColour: Color.black, bColour: Color.yellow, Opac: 0.625, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[15], fColour: Color.black, bColour: Color.yellow, Opac: 0.625, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[19], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                                          ButtonView(counter: $extraArray6[23], fColour: CustomMag.HC_Mag, bColour: Color.gray, Opac: 0.625, isAdd: $isAdd)
                                      }
                                  }
                                  else {
                                  }
                                      if quarterInt == 5 {
                                     // Totals
                                      HStack {
                                          Text("\(extraArray6[0..<4].reduce(0,+))")
                                              .font(.caption)
                                              .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                              .frame(width:40 , height:35, alignment: .center)
                                              .border(.gray)
                                          Text("\(extraArray6[4..<8].reduce(0,+))")
                                              .font(.caption)
                                              .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                              .padding(.all)
                                              .frame(width:40 , height:35, alignment: .center)
                                            Text("\(extraArray6[8..<12].reduce(0,+))")
                                                .font(.caption)
                                                .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                                .padding(.all)
                                                .frame(width:40 , height:35, alignment: .center)
                                          Text("\(extraArray6[12..<16].reduce(0,+))")
                                              .font(.caption)
                                              .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                              .padding(.all)
                                              .frame(width:40 , height:35, alignment: .center)
                                          Text("\(extraArray6[16..<20].reduce(0,+))")
                                              .font(.caption)
                                              .foregroundColor(CustomMag.HC_Mag.opacity(0.5))
                                              .padding(.all)
                                              .frame(width:40 , height:35, alignment: .center)
                                          Text("\(extraArray6[20..<24].reduce(0,+))")
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
                  }
                  .onAppear() {
                      updatehcMarkArray()
                  }
              }
            
              // convert integer array into string to save in AppStorage
              func updatehcMark() {
                  
                  extraStringArray6 = extraArray6.map{String($0)}
                 extra6 = extraStringArray6.joined(separator: ",")
              }
              // convert AppStorage string into integer array and update Array
            func updatehcMarkArray() {
                if extra6 == "" {
                    extra6 = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"
                    extraArray6  = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
                    
                } else {
                        extraArray6 = extra6.components(separatedBy: ",").map { Int($0) ?? 0  }
                    }
            }
          }

struct ExtraView6_Previews: PreviewProvider {
    static var previews: some View {
        ExtraView6(quarterInt: .constant(1))
    }
}
