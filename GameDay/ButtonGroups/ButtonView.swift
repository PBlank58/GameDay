//
//  ButtonView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 29/8/2023.
//

import SwiftUI

struct ButtonView: View {

    @Binding var counter: Int 
    @State var fColour: Color = Color.gray
    @State var bColour: Color = Color.gray
    @State var Opac: Double = 0.125
    @Binding var isAdd: Bool
  
    
    var body: some View {
        
        Button(action: {self.counter += isAdd ? 1 : -1}) {
            Text("\(counter)")
                .font(.caption)
                .foregroundColor(fColour)
                .padding(.all)
                .background(bColour.opacity(Opac))
                .frame(width:45 , height:35)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
    }
}



