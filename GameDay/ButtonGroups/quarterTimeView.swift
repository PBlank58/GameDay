//
//  quarterTimeView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 10/4/2024.
//

import SwiftUI


struct quarterTimeView: View {
    @StateObject var timeViewModel: TimeViewModel = TimeViewModel()
    
    @Environment(\.dismiss) var dismiss
    //Custom Colours
    struct CustomGold { static let HC_Gold = Color("HC_Gold")  }
    struct CustomMag { static let HC_Mag = Color("HC_Magenta") }
    
   
    var body: some View {
        Button {
            dismiss()
            
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Text("Quarter lengths")
            .padding(.horizontal)
            .font(.title)
            .bold()
        List {
            ForEach (timeViewModel.timeArray.sorted(by: {$0.quarter < $1.quarter})) {  qtime in
                HStack { Spacer(minLength: 250)
                    Text("Quarter \(qtime.quarter)")
                        .font(.title2)
                        .foregroundColor(CustomMag.HC_Mag)
                    Text(qtime.time)
                        .bold()
                        .padding(.horizontal)
                        .font(.title3)
                    Spacer()
                    Spacer()
                }
            }
                        .onDelete(perform: delete)
                        .onMove(perform: move)
          
                }
        
        .onDisappear() {
            timeViewModel.saveTime()
        }
    
    }
      
    func delete(indexSet: IndexSet) {
    timeViewModel.timeArray.remove(atOffsets: indexSet)
        timeViewModel.saveTime()
    }
    func move(indices: IndexSet, newOffset: Int) {
    timeViewModel.timeArray.move(fromOffsets: indices, toOffset: newOffset)
     
        }
}

#Preview {
    quarterTimeView()
}
