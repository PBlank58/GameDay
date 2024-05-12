//
//  AddMatchDetailsView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 31/8/2023.
//

import SwiftUI

struct AddMatchDetailsView: View {
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }
    @StateObject var matchViewModel: MatchViewModel = MatchViewModel()
    @ObservedObject var competitionViewModel: CompetitionViewModel
    @ObservedObject var levelViewModel: LevelViewModel
    @ObservedObject var venueViewModel: VenueViewModel
    @ObservedObject var teamViewModel: TeamViewModel
    @ObservedObject var roundViewModel: RoundViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var competition = ""
    @State var level = ""
    @State private var venue = ""
    @State private var home = ""
    @State private var opponent = ""
    @State var round = ""
    
    
    @State private var alertDeleteAll = false
  
    @State var gameDate: Date = Date()
 
    // filters
    
    // filter competitions to force refresh
     var filteredCompetitions: [CompetitionModel] {
         if competitionViewModel.competitionArray.count == 0 {
             return competitionViewModel.competitionArray.sorted(by:  {
                 $0.competition <  $1.competition })
         } else {
             return competitionViewModel.competitionArray.sorted(by:  {
                 $0.competition <  $1.competition })
         }
     }
    // filter levels to force refresh
     var filteredLevels: [LevelModel] {
         if levelViewModel.levelArray.count == 0 {
             return levelViewModel.levelArray.sorted(by:  {
                 $0.Grade <  $1.Grade })
         } else {
             return levelViewModel.levelArray.sorted(by:  {
                 $0.Grade <  $1.Grade} )
         }
     }
    // filter oppositions to force refresh
     var filteredTeams: [TeamModel] {
         if teamViewModel.teamArray.count == 0 {
             return teamViewModel.teamArray.sorted(by:  {
                 $0.Team <  $1.Team })
         } else {
             return teamViewModel.teamArray.sorted(by:  {
                 $0.Team <  $1.Team} )
         }
     }
    // filter venues to force refresh
     var filteredVenues: [VenueModel] {
         if venueViewModel.venueArray.count == 0 {
             return venueViewModel.venueArray.sorted(by:  {
                 $0.venue <  $1.venue })
         } else {
             return venueViewModel.venueArray.sorted(by:  {
                 $0.venue <  $1.venue} )
         }
     }
    // filter rounds to force refresh
     var filteredRounds: [RoundModel] {
         if roundViewModel.roundArray.count == 0 {
             return roundViewModel.roundArray.sorted(by:  {
                 $0.Round <  $1.Round })
         } else {
             return roundViewModel.roundArray.sorted(by:  {
                 $0.Round <  $1.Round} )
         }
     }
    var body: some View {
       
            Form() {
                Section {
                    HStack {
                        Picker("Home Team", selection: self.$home) {
                            Text("No Option").tag(Optional<String>(nil))
                            ForEach(filteredTeams) { team in
                                Text(team.Team)
                                    .tag(team.Team)
                            }
                        }
                    }
                }
                .bold()
                .font(.title2)
                Section {
                    HStack {
                        Picker("Competition", selection: self.$competition) {
                            Text("No Option").tag(Optional<String>(nil))
                            ForEach(filteredCompetitions) { comp in
                                Text(comp.competition)
                                    .tag(comp.competition)
                            }
                        }
                        Picker("Level", selection: self.$level) {
                            Text("No Option").tag(Optional<String>(nil))
                            ForEach(filteredLevels) { level in
                                Text(level.Grade)
                                    .tag(level.Grade)
                            }
                        }
                    }
                }
                Section {
                    
                    HStack {
                        Picker("Opposition", selection: $opponent) {
                            Text("No Option").tag(Optional<String>(nil))
                            ForEach(filteredTeams) { team in
                                Text(team.Team)
                                    .tag(team.Team)
                            }
                        }
                        Picker("Venue", selection: $venue) {
                            Text("No Option").tag(Optional<String>(nil))
                            ForEach(filteredVenues) { venue in
                                Text(venue.venue)
                                    .tag(venue.venue)
                            }
                        }
                    }
                }
                Section {
                    HStack {
                        Picker("Round", selection: $round) {
                            Text("No Option").tag(Optional<String>(nil))
                            ForEach(filteredRounds) { round in
                                Text(round.Round)
                                    .tag(round.Round)
                            }
                        }
                        
                        DatePicker(selection: $gameDate,  displayedComponents:[ .date, .hourAndMinute]) {
                            Text("Date and time")
                        }
                    }
                }
                
            }
                  
                Button {
                    saveMatchDetails()
                } label: {
                    Text("Save")
                        .padding()
                        .foregroundStyle(.white)
                        .background(CustomMag.HC_Mag)
                        .clipShape(Capsule())
                        .padding()
                }
               
            .navigationTitle("Match Details")
            .toolbar {
                HStack { 
                    Button() {
                        alertDeleteAll.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "minus.square.fill")
                            Text("Delete All")
                        }
                    }
                    Button() {
                        dismiss()
                    } label: {
                        VStack {
                            Image(systemName: "multiply.circle")
                            Text("Cancel")
                        }
                    }
                }
                
                .foregroundColor(CustomMag.HC_Mag)
            }
            
            if matchViewModel.matchArray.indices.contains(0)  {
               
                    Text("Match Details")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                       
                VStack {
                    Text(matchViewModel.matchArray[0].competition)
                     Text(matchViewModel.matchArray[0].level)
                    Text("\(Int(matchViewModel.matchArray[0].round)  != nil ? "Round " : "")\(matchViewModel.matchArray[0].round)")
                        .padding(.bottom)
                   
                        Text("\(matchViewModel.matchArray[0].home) v \(matchViewModel.matchArray[0].opponent)")
                       
                    .foregroundColor(CustomMag.HC_Mag)
                   
                    .padding(.bottom)
                
                        Text("\(matchViewModel.matchArray[0].gameDate.formatted(.dateTime.day().month().year()))")
                      
                         
                        Text(" \(matchViewModel.matchArray[0].gameDate, style: .time)")
                        
                    .padding(.bottom)
                  
                    HStack {
                        Text("at ")
                            
                    Text(matchViewModel.matchArray[0].venue)
                           
                    }
                   
                }
                .font(.title2)
                .frame(minWidth: 300)
                .padding()
                    .border(CustomMag.HC_Mag)
               
            } else {
                Text("No game details")
            }
          
              
                NavigationLink {
                    AddMatchItemView(matchViewModel: MatchViewModel(), competitionViewModel: CompetitionViewModel(), levelViewModel: LevelViewModel(), venueViewModel: VenueViewModel(), teamViewModel: TeamViewModel(), roundViewModel: RoundViewModel()) } label: {
                        Text("Add list item")
                            .padding()
                            .frame(maxWidth: 300)
                            .foregroundColor(CustomMag.HC_Mag)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .buttonStyle(.plain)
                            .font(.title3)
                            .padding()
                    }
          // if present load match details
                    .onAppear {
                            if matchViewModel.matchArray.count != 0 {
                            self.home = self.matchViewModel.matchArray[0].home
                            self.competition = self.matchViewModel.matchArray[0].competition
                            self.venue = self.matchViewModel.matchArray[0].venue
                            self.opponent = self.matchViewModel.matchArray[0].opponent
                            self.level = self.matchViewModel.matchArray[0].level
                            self.round = self.matchViewModel.matchArray[0].round
                                }
                            
                        }
                        
        .alert(isPresented:$alertDeleteAll) {
            Alert(
                title: Text("This will clear all players"),
                message: Text("There is no undo"),
                primaryButton: .destructive(Text("Delete")) {
                    deleteAll()
                },
                secondaryButton: .cancel()
            )
        }
    }
   func  saveMatchDetails() {
     
      // fix School abbreviation
       let game = MatchModel()
       game.gameDate = gameDate
       game.competition = competition
       game.level = level
       game.round = round
       game.home = home
       if teamViewModel.teamArray.filter({$0.Team == home}).count != 0 {
           game.homeAbbr = teamViewModel.teamArray.filter({$0.Team == home})[0].TeamAbbr
       } else {
           game.homeAbbr = ""
       }
       game.venue = venue
       game.opponent = opponent
       if teamViewModel.teamArray.filter({$0.Team == opponent}).count != 0 {
           game.oppAbbr = teamViewModel.teamArray.filter({$0.Team == opponent})[0].TeamAbbr
       } else {
           game.oppAbbr = ""
       }
      
 
       if  matchViewModel.matchArray.count > 0 {
           matchViewModel.matchArray.removeFirst()
       }
       if competition != "" && opponent  != ""  && level != "" && venue != "" {
           matchViewModel.addMatch(game)
       }
    }
    func deleteAll() {
        matchViewModel.matchArray.removeAll()
        matchViewModel.saveMatch()
    }
    
}


struct AddMatchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AddMatchDetailsView(matchViewModel: MatchViewModel(), competitionViewModel: CompetitionViewModel(), levelViewModel: LevelViewModel(), venueViewModel: VenueViewModel(), teamViewModel: TeamViewModel(), roundViewModel: RoundViewModel())
    }
}
