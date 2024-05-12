//
//  QuarterHeaderView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 30/8/2023.
//

import SwiftUI



struct QuarterHeaderView: View {
     
            //Custom Colours
            struct CustomGold {
                static let HC_Gold = Color("HC_Gold")
            }
            struct CustomMag {
                static let HC_Mag = Color("HC_Magenta")
            }
    @Binding var quarterInt: Int
    var body: some View {
        VStack {
            VStack {
                
                HStack {
                    VStack {
                            Text(" ")
                                .frame(width: 40,  height:35)
                            Text("Q  ")
                                .frame(width: 40,  height:35)
                            Text("1")
                                .frame(width:40 , height:35)
                            Text("2")
                            .frame(width:40 , height:35)
                            Text("3")
                            .frame(width:40 , height:35)
                            Text("4")
                            .frame(width:40 , height:35)
                            Text("T")
                            .frame(width:40 , height:35)
                    }
                    .font(.caption)
                   
                }
                
                
            }
            .padding()
           
            .frame(maxWidth: 35, minHeight: 10)
            .border(CustomMag.HC_Mag)
            .background(Color.gray.opacity(0.1))
            .padding()
            
            
        }
    }
}

              struct QuarterHeaderView_Previews: PreviewProvider {
                  static var previews: some View {
                      QuarterHeaderView(quarterInt: .constant(1))
                  }
              }

          
