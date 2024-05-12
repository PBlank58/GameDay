//
//  ContentView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 29/8/2023.
//

import SwiftUI
import CoreData

struct InputView: View {
    
    @StateObject var gameDetails = MatchViewModel()
  
    @State private var showQuarterSummary: Bool = false
    @State private var showScoreDetail: Bool = false
    @State private var showQtimes = false
    @Environment(\.dismiss) private var dismiss
  
    
    //Magnification variables
    @State private var currentAmount = 0.0
    @State var finalAmount = 1.0
    
    @StateObject var timeViewModel: TimeViewModel = TimeViewModel()
    @AppStorage("clearance") var clearance = ""
    @AppStorage("quarterInt") var quarterInt = 0
    @State private var showExtra2 = false
    @State private var showExtra4 = false
    @State private var showExtra6 = false
    
    
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View { 
        HStack {
            Spacer(minLength: 10)
            Text("Quarter")
                .foregroundColor(CustomMag.HC_Mag)
          // Quarter 1
            VStack {
                Button {
                    quarterInt = 1
                } label: {
                    Text(" ")
                        .frame(width: 15, height: 15)
                        .background(quarterInt == 1 ? CustomMag.HC_Mag : Color.white)
                        .cornerRadius(100)
                        .foregroundColor(CustomMag.HC_Mag)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 100)
                            .stroke(CustomMag.HC_Mag, lineWidth: 4)
                            .scaleEffect(0.5)
                        )
                }
                    Text("1")
                        .foregroundColor(CustomMag.HC_Mag)
                }
           
            // Quarter 2
            VStack {
                Button {
                  quarterInt = 2
              } label: {
                  Text(" ")
                      .frame(width: 15, height: 15)
                      .background(quarterInt == 2 ? CustomMag.HC_Mag : Color.white)
                      .cornerRadius(100)
                      .foregroundColor(CustomMag.HC_Mag)
                      .padding()
                      .overlay(RoundedRectangle(cornerRadius: 100)
                          .stroke(CustomMag.HC_Mag, lineWidth: 4)
                          .scaleEffect(0.5)
                      )
              }
                  Text("2")
                      .foregroundColor(CustomMag.HC_Mag)
              }
            // Quarter 3
            VStack {
              Button {
                  quarterInt = 3
              } label: {
                  Text(" ")
                      .frame(width: 15, height: 15)
                      .background(quarterInt == 3 ? CustomMag.HC_Mag : Color.white)
                      .cornerRadius(100)
                      .foregroundColor(CustomMag.HC_Mag)
                      .padding()
                      .overlay(RoundedRectangle(cornerRadius: 100)
                          .stroke(CustomMag.HC_Mag, lineWidth: 4)
                          .scaleEffect(0.5)
                      )
              }
                  Text("3")
                      .foregroundColor(CustomMag.HC_Mag)
              }
            // Quarter 4
            VStack {
              Button {
                  quarterInt = 4
              } label: {
                  Text(" ")
                      .frame(width: 15, height: 15)
                      .background(quarterInt == 4 ? CustomMag.HC_Mag : Color.white)
                      .cornerRadius(100)
                      .foregroundColor(CustomMag.HC_Mag)
                      .padding()
                      .overlay(RoundedRectangle(cornerRadius: 100)
                          .stroke(CustomMag.HC_Mag, lineWidth: 4)
                          .scaleEffect(0.5)
                      )
              }
                  Text("4")
                      .foregroundColor(CustomMag.HC_Mag)
              }
            // All
            VStack {
              Button {
                  quarterInt = 5
              } label: {
                  Text(" ")
                      .frame(width: 15, height: 15)
                      .background(quarterInt == 5 ? CustomMag.HC_Mag : Color.white)
                      .cornerRadius(100)
                      .foregroundColor(CustomMag.HC_Mag)
                      .padding()
                      .overlay(RoundedRectangle(cornerRadius: 100)
                          .stroke(CustomMag.HC_Mag, lineWidth: 4)
                          .scaleEffect(0.5)
                      )
              }
                  Text("All")
                      .foregroundColor(CustomMag.HC_Mag)
              }
            Spacer()
            BodyTimer(quarterInt: $quarterInt)
            Spacer(minLength: 10)
                }
        ScrollView([.horizontal])  {
            ScrollView([.vertical])  {
                VStack(spacing: -15){
                    Spacer()

                       
                    HStack(spacing: -15)  {
                        if quarterInt == 5 {
                            QuarterHeaderView(quarterInt: $quarterInt)
                        } else {
                        }
                        ClearancesView(quarterInt: $quarterInt)
                        if quarterInt == 5 {
                            QuarterHeaderView(quarterInt: $quarterInt)
                        } else {
                        }
                        ContestView(quarterInt: $quarterInt)
                        RepeatStopView(quarterInt: $quarterInt)
                        TacklesView(quarterInt: $quarterInt)
                        MissedTackles(quarterInt: $quarterInt)
                        if quarterInt == 5 {
                            QuarterHeaderView(quarterInt: $quarterInt)
                        } else {
                        }
                        Spacer()
                    }
                   
                    HStack(spacing: -15) {
                        if quarterInt == 5 {
                            QuarterHeaderView(quarterInt: $quarterInt)
                        } else {
                        }
                        HCMarksView(quarterInt: $quarterInt)
                        if quarterInt == 5 {
                            QuarterHeaderView(quarterInt: $quarterInt)
                        } else {
                        }
                        DefenceView(quarterInt: $quarterInt)
                        OpMarksView(quarterInt: $quarterInt)
                       
                     
                        if quarterInt == 5 {
                            QuarterHeaderView(quarterInt: $quarterInt)
                        } else {
                        }
                        
                    }
                    HStack(spacing: -15) {
                        if quarterInt == 5 {
                            QuarterHeaderView(quarterInt: $quarterInt)
                        } else {
                        }
                       
                        HCInside40View(quarterInt: $quarterInt)
                        if quarterInt == 5 {
                            QuarterHeaderView(quarterInt: $quarterInt)
                        } else {
                        }
                      
                        OpInside40View(quarterInt: $quarterInt)
                        if quarterInt == 5 {
                            QuarterHeaderView(quarterInt: $quarterInt)
                        } else {
                        }
                        PossChainView(quarterInt: $quarterInt)
                        PressureView(quarterInt: $quarterInt)
                        SpoilsView(quarterInt: $quarterInt)
                      
                     
                       
                    }
                    HStack(spacing: -15) {
                        if quarterInt == 5 {
                            QuarterHeaderView(quarterInt: $quarterInt)
                        } else {
                        }
                        Spacer()
                        VStack {
                            Button {
                                showExtra6.toggle()
                            } label: {
                                    Text(showExtra6 ? "hide 6" : "show 6")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(CustomMag.HC_Mag.opacity(0.6))
                                    .cornerRadius(10)
                                    
                                }
                            .padding()
                                if showExtra6 == true {
                                    ExtraView6(quarterInt: $quarterInt)
                                        .frame(maxWidth: 300)
                                } else { }
                        }
                        Spacer()
                        VStack {
                            Button {
                                showExtra4.toggle()
                            } label: {
                                    Text(showExtra4 ? "hide 4" : "show 4")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(CustomMag.HC_Mag.opacity(0.6))
                                    .cornerRadius(10)
                                    
                                }
                            .padding()
                                if showExtra4 == true {
                                    ExtraView4(quarterInt: $quarterInt)
                                        .frame(maxWidth: 200)
                                } else { }
                        }
                        Spacer()
                        VStack {
                            Button {
                                showExtra2.toggle()
                            } label: {
                                    Text(showExtra2 ? "hide 2" : "show 2")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(CustomMag.HC_Mag.opacity(0.6))
                                    .cornerRadius(10)
                                    
                                }
                            .padding()
                                if showExtra2 == true {
                                    ExtraView2(quarterInt: $quarterInt)
                                        .frame(maxWidth: 100)
                                } else { }
                        }
                       
                            Spacer()
                        }
                    }
                }
            }
        // MARK: Magnification
        .scaleEffect(finalAmount + currentAmount)
        .gesture(
        MagnificationGesture()
            .onChanged { amount in
                currentAmount = amount - 1
            }
            .onEnded { amount in
                finalAmount += currentAmount
                currentAmount = 0
            }
        )
            
            .sheet(isPresented: $showScoreDetail) {
                ScoreView(quarterInt: $quarterInt)
            }
           
            .navigationTitle("Game Inputs")
            .navigationBarTitleDisplayMode(.automatic)
           
            .navigationBarItems (
                trailing:
                    HStack {
                        //Button to show quarter lengths
                        Button {
                            showQtimes.toggle()
                        } label: {
                            VStack {
                                Image(systemName: "timer.circle.fill")
                                Text("Q times")
                            }
                                .foregroundColor(CustomMag.HC_Mag)
                        }
                        Spacer()
                        Button {
                            showScoreDetail.toggle()
                        }
                        
                    label: {
                            VStack {
                                Label("Score", systemImage: "figure.australian.football")
                                Text("Score")
                            }
                        }
                        .disabled(quarterInt == 5)
                        .foregroundColor(quarterInt == 5 ? .gray.opacity(0.6) : CustomMag.HC_Mag)
                        
                        
                        .padding()
                    }
                )
            .sheet(isPresented: $showQtimes) {
               
                quarterTimeView()
                        .padding()
                       
            }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(gameDetails: MatchViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
       
    }
}
