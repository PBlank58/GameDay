//
//  GameOutputView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 9/5/2024.
//

import SwiftUI

struct GameOutputView: View {
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
           
    }
    @StateObject var matchViewModel = MatchViewModel()
    
    var body: some View {
        // title
        HStack { 
            Text("STATISTICS SUMMARY")
                .font(.title2)
                .padding()
                .foregroundColor(CustomMag.HC_Mag)
            
            Spacer()
        }
        // game details
        HStack {
            if matchViewModel.matchArray.count == 0 {
              Text("no match details")
                    .font(.title2)
                    .padding()
                    .foregroundColor(CustomMag.HC_Mag)
            } else {
                Text("Round \(matchViewModel.matchArray[0].round)       \(matchViewModel.matchArray[0].gameDate.formatted(.dateTime.day().month().year()))")
                    .font(.title2)
                    .padding()
                    .foregroundColor(CustomMag.HC_Mag)
               
            }
            Spacer()
        }
        HStack {
            Text("Quarter Summary")
                .font(.title2)
                .padding()
                .foregroundColor(CustomMag.HC_Mag)
            Spacer()
        }
    
    }
        
}

#Preview {
    GameOutputView()
}
