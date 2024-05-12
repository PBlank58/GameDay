
//  ContentView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 4/9/2023.
//

import SwiftUI

struct ContentView: View {
    
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }
    // Game details
    @StateObject var gameDetails = MatchViewModel()
    @StateObject var scoreDetails = ScoreViewModel()
   
    
    // Reset the whole sheet
    @State private var isReset = false
    @State private var showingAlert  = false
  
  
    @AppStorage("missedtackle") var missedTackle = ""
    @AppStorage("hcmarks") var hcmarks = ""
    @AppStorage("opmarks") var opmarks = ""
    @AppStorage("repeatS") var repeatS = ""
    @AppStorage("spoils") var spoils = ""
    @AppStorage("pressure") var pressure = ""
    @AppStorage("chain") var chain = ""
    @AppStorage("extra2") var extra2 = ""
    @AppStorage("extra4") var extra4 = ""
    @AppStorage("extra6") var extra6 = ""
    @AppStorage("isDarkMode") var isDarkMode = false
    @AppStorage("clearance") var clearance = ""
    @AppStorage("contested") var contested = ""
    @AppStorage("tackles") var tackles = ""
    @AppStorage("hcInside40") var hcInside40 = ""
    @AppStorage("opInside40") var opInside40 = ""
    @AppStorage("Score") var Score = ""
    @AppStorage("defence") var defence = ""
  
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(colors:  [CustomGold.HC_Gold,Color.gray.opacity(0.3)], center: .topTrailing, startRadius: 100, endRadius: 500)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Toggle("Mode", isOn: $isDarkMode)
                            .foregroundColor(isDarkMode ?  .white : CustomMag.HC_Mag )
                            .padding(.horizontal)
                            .toggleStyle(SwitchToggleStyle(tint: CustomGold.HC_Gold))
                            .frame(width: 150, alignment: .leading)
                        Spacer()
                    }
                    HStack {
                        NavigationLink
                        { AddMatchDetailsView(matchViewModel: MatchViewModel(), competitionViewModel: CompetitionViewModel(), levelViewModel: LevelViewModel(), venueViewModel: VenueViewModel(), teamViewModel: TeamViewModel(), roundViewModel: RoundViewModel()) } label: {
                            Text("Match Details")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.6))
                                .border(.gray)
                                .cornerRadius(20)
                                .buttonStyle(.plain)
                                .font(.title)
                                .foregroundColor(CustomMag.HC_Mag)
                                .padding()
                            
                        }
                        NavigationLink {  AddPlayerDetailsView(playerViewModel: PlayerViewModel())
                        } label: {
                            Text("Player Details")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.6))
                                .border(.gray)
                                .cornerRadius(20)
                                .buttonStyle(.plain)
                                .font(.title)
                                .foregroundColor(CustomMag.HC_Mag)
                                .padding()
                            
                        }
                    }
                    Spacer()
                    NavigationLink {  InputView()
                    } label: {
                        Text("Game Day")
                            .padding()
                            .frame(maxWidth: .infinity)
                        
                            .background(Color.white)
                            .border(.gray)
                            .cornerRadius(20)
                            .buttonStyle(.plain)
                            .font(.title)
                            .foregroundColor(CustomMag.HC_Mag)
                            .padding()
                        
                    }
                    Spacer()
               
                    NavigationLink {  QuarterSummaryView(matchDetails: MatchViewModel() )
                    } label: {
                        Text("Quarter Summary")
                            .padding()
                            .frame(maxWidth: .infinity)
                        
                            .background(Color.gray.opacity(0.6))
                            .border(.gray)
                            .cornerRadius(20)
                            .buttonStyle(.plain)
                            .font(.title)
                            .foregroundColor(CustomMag.HC_Mag)
                            .padding()
                        
                    }
                    NavigationLink {  LineSummaryView(matchDetails: MatchViewModel() )
                    } label: {
                        Text("Line Summary")
                            .padding()
                            .frame(maxWidth: 400)
                        
                            .background(Color.gray.opacity(0.4))
                            .border(.gray)
                            .cornerRadius(20)
                            .buttonStyle(.plain)
                            .font(.title)
                            .foregroundColor(CustomMag.HC_Mag)
                            .padding()
                        
                    }
                    NavigationLink {  QSScoreSummaryView()
                    } label: {
                        Text("Score Summary")
                            .padding()
                            .frame(maxWidth: 400)
                        
                            .background(Color.gray.opacity(0.4))
                            .border(.gray)
                            .cornerRadius(20)
                            .buttonStyle(.plain)
                            .font(.title)
                            .foregroundColor(CustomMag.HC_Mag)
                            .padding()
                    }
        Spacer()
                    HStack {
                        NavigationLink {  ImportExportView(playerViewModel: PlayerViewModel(), matchViewModel: MatchViewModel(), scoreViewModel: ScoreViewModel(), timeViewModel: TimeViewModel(), teamViewModel: TeamViewModel(), venueViewModel: VenueViewModel(), competitionViewModel: CompetitionViewModel(), roundViewModel: RoundViewModel(), levelViewModel: LevelViewModel() )
                        } label: {
                            Text("Import Export by Modules")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(CustomGold.HC_Gold.opacity(0.6))
                                .border(.gray)
                                .cornerRadius(20)
                                .buttonStyle(.plain)
                                .font(.title)
                                .foregroundColor(CustomMag.HC_Mag)
                                .padding()
                        }
                        NavigationLink {  ImportExportBulkView(playerViewModel: PlayerViewModel(), matchViewModel: MatchViewModel(), scoreViewModel: ScoreViewModel(), timeViewModel: TimeViewModel(), teamViewModel: TeamViewModel(), venueViewModel: VenueViewModel(), competitionViewModel: CompetitionViewModel(), roundViewModel: RoundViewModel(), levelViewModel: LevelViewModel() )
                        } label: {
                            Text("Import Export Complete")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(CustomGold.HC_Gold.opacity(0.6))
                                .border(.gray)
                                .cornerRadius(20)
                                .buttonStyle(.plain)
                                .font(.title)
                                .foregroundColor(CustomMag.HC_Mag)
                                .padding()
                        }
                    }
               
                    Spacer()
                    Button { isReset = true
                    } label: {
                        Text("Reset All")
                            .padding()
                            .frame(maxWidth: .infinity)
                        
                            .background(CustomMag.HC_Mag)
                            .border(.gray)
                            .cornerRadius(20)
                            .buttonStyle(.plain)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                        
                    }
                }
                .navigationTitle("Main Menu")
            
            }
            
        }
        .navigationViewStyle(.stack)
        .alert(isPresented: $isReset) {
            Alert(
                title: Text("If you proceed all data will be reset"),
                message: Text("Reset Goalkickers in Score Input."),
                primaryButton: .cancel(
                    Text("Cancel"),
                    action: { }
                ),
                secondaryButton: .destructive(
                    Text("Reset"),
                    action: {
                        resetAll()
                        scoreDetails.resetAllScores()
                        
                    }
                )
            )
        }
    }
    func resetAll() {
        withAnimation(.spring()) {
            clearance = ""
            tackles = ""
            contested = ""
            missedTackle = ""
            hcmarks = ""
            opmarks = ""
            hcInside40 = ""
            opInside40 = ""
            repeatS = ""
            spoils = ""
            pressure = ""
            chain = ""
            extra2 = ""
            extra4 = ""
            extra6 = ""
            defence = ""
            isReset = false
            UserDefaults.standard.removeObject(forKey: "time")
            UserDefaults.standard.removeObject(forKey: "score")
           
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .background(Color.orange)
    }
}

