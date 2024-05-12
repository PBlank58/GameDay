//
//  LineSummaryView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 17/4/2024.
//

import SwiftUI

struct LineSummaryView: View {
    @StateObject var matchDetails: MatchViewModel
    
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }
    @State private var addLineType = "Forwards"
    
    var body: some View {
       
        if matchDetails.matchArray.count != 0  {
           
            HStack {
                Spacer()
                Text(matchDetails.matchArray[0].competition + " " + matchDetails.matchArray[0].level)
                    .font(.title2)
                Text("\(matchDetails.matchArray[0].home) v ")
                    .font(.title2)
                Text(matchDetails.matchArray[0].opponent)
                    .font(.title2)
                Spacer()
                Text("Round")
                    .font(.title2)
                Text("\(matchDetails.matchArray[0].round),")
                    .font(.title2)
                Text("\(matchDetails.matchArray[0].gameDate, format: .dateTime.year())")
                    .font(.title2)
                Spacer()
            }
            .foregroundColor(CustomMag.HC_Mag)
            .padding(.top)
            
            
        } else {
            Text("No game details")
        }
        Picker("Add", selection: $addLineType) {
            Text("Forwards").tag("Forwards")
            Text("Mids").tag("Mids")
            Text("Backs").tag("Backs")
            
        }.pickerStyle(SegmentedPickerStyle())
            .padding()
        ScrollView(.horizontal) {
           
                Group{
                    Text(addLineType)
                        .font(.title2)
                        .foregroundStyle(Color.blue)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Headers
                    switch addLineType {
                    case "Forwards":
                        LSForwardsView(matchDetails: MatchViewModel())
                    case "Mids":
                        LSMidsView(matchDetails: MatchViewModel())
                    case "Backs":
                        LSBacksView(matchDetails: MatchViewModel())
                        
                    default:
                        Text("default")
                    }
                    Spacer()
                }
                .navigationTitle("Line Summary")
            }
         
        }
    }


#Preview {
    LineSummaryView(matchDetails: MatchViewModel())
}
extension LineSummaryView {
    private var Headers: some View {
    HStack {
        Group {
            Text("Quarter")
                .padding()
                .frame(width: 260, height: 45)
                .border(.gray)
                .foregroundColor(CustomMag.HC_Mag)
                .padding(.horizontal)
            // First Quarter
            Text("1st")
                .padding()
                .frame(width: 70, height: 45)
                .border(.gray)
                .foregroundColor(CustomMag.HC_Mag)
            // Second Quarter
            Text("2nd")
                .padding()
                .frame(width: 70, height: 45)
                .border(.gray)
                .foregroundColor(CustomMag.HC_Mag)
                .background(.gray.opacity(0.1))
            // Third Quarter
            Text("3rd")
                .padding()
                .frame(width: 70, height: 45)
                .border(.gray)
                .foregroundColor(CustomMag.HC_Mag)
            // Fourth Quarter
                Text("4th")
                    .padding()
                    .frame(width: 70, height: 45)
                    .border(.gray)
                    .foregroundColor(CustomMag.HC_Mag)
                    .background(.gray.opacity(0.1))
            Text("Total")
                    .padding()
                    .frame(width: 100, height: 45)
                    .foregroundColor(CustomMag.HC_Mag)
                    .background(CustomMag.HC_Mag.opacity(0.1))
                    .border(.gray)
                     .padding(.horizontal)
        }
        .font(.title3)

        }
    }
}
