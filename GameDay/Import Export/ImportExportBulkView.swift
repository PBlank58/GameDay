//
//  ImportExport2view.swift
//  GameDay
//
//  Created by Brett Pullyblank on 23/12/2023.
//

import SwiftUI

struct ImportExportBulkView: View {
    
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }
    // call up for view models
    @StateObject var playerViewModel: PlayerViewModel
    @StateObject var matchViewModel: MatchViewModel
    @StateObject var scoreViewModel: ScoreViewModel
    @StateObject var timeViewModel: TimeViewModel
    @StateObject var teamViewModel: TeamViewModel
    @StateObject var venueViewModel: VenueViewModel
    @StateObject var competitionViewModel: CompetitionViewModel
    @StateObject var roundViewModel: RoundViewModel
    @StateObject var levelViewModel: LevelViewModel
  
    
    // call up all appstorage to export or update
    @AppStorage("contested") var contested = ""
    @AppStorage("clearance") var clearance = ""
    @AppStorage("tackles") var tackles = ""
    @AppStorage("missedtackle") var missedTackle = ""
    @AppStorage("hcmarks") var hcmarks = ""
    @AppStorage("opmarks") var opmarks = ""
    @AppStorage("opInside40") var opInside40 = ""
    @AppStorage("hcInside40") var hcInside40 = ""
    @AppStorage("repeatS") var repeatS = ""
    @AppStorage("spoils") var spoils = ""
    @AppStorage("pressure") var pressure = ""
    @AppStorage("chain") var chain = ""
    @AppStorage("defence") var defence = ""
    @AppStorage("extra2") var extra2 = ""
    @AppStorage("extra4") var extra4 = ""
    @AppStorage("extra6") var extra6 = ""
    @AppStorage("isDarkMode") var isDarkMode = false
   
   
    
    //export string for appStorage
    @State private var appStorageString = ""
    @State private var exportType = "team"
    @State private var heading = "id, Surname, first name, number"
    @State private var csvRows = [""]
    @State private var csvFileName = "team"
    @State private var csvAppStorageName = ""
    @State private var importGame = false
    
    // check if valiues are in existing lists
   
    //import string for ViewModels
    @State private var importText = ""
    @State private var importType = "team"
    @State private var completeBool = false
    
    
    var body: some View {
        ScrollView {
        VStack {
            Text("Export Files")
                .font(.largeTitle)
                .bold()
                .padding()
           
        }
            Text("To save Match Detail lists go to Match Details Page then \"Add List Item\" ")
        ShareLink(item:generateModelCSV())
        {
            
                Text("Export Game")
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
        
        
        
        
        Rectangle()
            .fill(CustomMag.HC_Mag)
            .frame(maxWidth: .infinity, maxHeight: 5)
    
            Text("Import Files")
                .font(.largeTitle)
                .bold()
                .padding()
    
        
                // Bulk entry using csv
               
                Button() {
                    importGame = true
                } label: {
                    Text("Select CSV File")
                        .padding()
                        .foregroundStyle(.white)
                        .background(CustomMag.HC_Mag)
                        .clipShape(Capsule())
                        .padding()
                }
                     .fileImporter(
                         isPresented: $importGame,
                         allowedContentTypes: [.commaSeparatedText]
                     ) {
                         result in
                         switch result {
                         case .success(let success):
                             importCSV(success)
                         case .failure(let failure):
                             print(failure.localizedDescription)
                         }
                     }

           
            Button {
                uploadCSV()
            } label: {
                Text("Upload Game File")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(CustomGold.HC_Gold.opacity(0.3))
                    .border(.gray)
                    .cornerRadius(20)
                    .buttonStyle(.plain)
                    .font(.title)
                    .foregroundColor(CustomMag.HC_Mag)
                    .padding()
            }
            .alert("Import complete", isPresented: $completeBool) {
                Button("OK", role: .cancel) { }
            }
            
       
        
        }
    }
  
        
  // create csv from updateExport function
    func generateModelCSV() -> URL {
        var fileURL: URL!
        
                let playerHeading = "id,Surname,Given,Number\n"
                let playerCsvRows = playerViewModel.playerArray.map { "\($0.id),\($0.Surname),\($0.Given),\($0.Guernsey)" }

                let matchHeading = "id,gameDate,competition,home,homeAbbr,venue,opposition,oppAbbr,level,round,launchArray\n"
        let matchCsvRows = matchViewModel.matchArray.map { "\($0.id),\($0.gameDate),\($0.competition),\($0.home),\($0.homeAbbr.trimmingCharacters(in: .whitespacesAndNewlines)),\($0.venue),\($0.opponent),\($0.oppAbbr.trimmingCharacters(in: .whitespacesAndNewlines)),\($0.level),\($0.round),\($0.launchArray)" }
           
                let scoreHeading = "id,quarter,team,ScoreEvent,goalScorer,scoreType,HCWorm,LauncherNo,typeNumber,OpWorm\n"
                let scoreCsvRows = scoreViewModel.scoreArray.map { "\($0.id),\($0.quarter),\($0.team),\($0.scoreEvent),\($0.goalScorer),\($0.scoreType),\($0.HCWorm),\($0.launchNummer),\($0.typeNummer),\($0.OpWorm)"}
            
                let timeHeading = "id,quarter,time\n"
                let timeCsvRows = timeViewModel.timeArray.map { "\($0.id),\($0.quarter),\($0.time)" }

        
            // heading of CSV file.
            let inputHeading = "appStorage, data\n"
            
            // file rows
            let csvContested = "contested," + contested + "\n"
            let csvClearance = "clearance," + clearance + "\n"
            let csvTackles = "tackles,"  + tackles + "\n"
            let csvTissedtackle = "missedTackle,"  + missedTackle + "\n"
            let csvHcmarks = "hcmarks,"  + hcmarks + "\n"
            let csvOpmarks = "opmarks,"  + opmarks + "\n"
            let csvOpInside40 = "opInside40,"  + opInside40 + "\n"
            let csvHcInside40 = "hcInside40,"  + hcInside40 + "\n"
            let csvRepeatS = "repeatS,"  + repeatS + "\n"
            let csvSpoils = "spoils,"  + spoils + "\n"
            let csvPressure = "pressure,"  + pressure + "\n"
            let csvChain = "chain,"  + chain + "\n"
            let csvExtra2 = "extra2,"  + extra2 + "\n"
            let csvExtra4 = "extra4,"  + extra4 + "\n"
            let csvExtra6 = "extra6,"  + extra6 + "\n"
            let csvDefence = "defence," + defence + "\n"
         
        
            // rows to string data
            let stringData =
            playerHeading + playerCsvRows.joined(separator: "\n")
            +  "\n$$\n"
            + matchHeading + matchCsvRows.joined(separator: "\n")
            +  "\n$$\n"
            + scoreHeading + scoreCsvRows.joined(separator: "\n")
            +  "\n$$\n"
            + timeHeading + timeCsvRows.joined(separator: "\n")
            +  "\n$$\n"
            + inputHeading
            + csvContested
            + csvClearance
            + csvTackles
            + csvTissedtackle
            + csvHcmarks
            + csvOpmarks
            + csvOpInside40
            + csvHcInside40
            + csvRepeatS
            + csvSpoils
            + csvPressure
            + csvChain
            + csvExtra2
            + csvExtra4
            + csvExtra6
            + csvDefence
       
            
            do {
                
                let path = try FileManager.default.url(for: .documentDirectory,
                                                       in: .allDomainsMask,
                                                       appropriateFor: nil,
                                                       create: false)
                
                if matchViewModel.matchArray.count == 0 {
                    fileURL = path.appendingPathComponent("export.csv")
                }  else {
                    fileURL = path.appendingPathComponent("\(matchViewModel.matchArray[0].opponent) r\(matchViewModel.matchArray[0].round).csv")
                }
                // append string data to file
                try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
                print(fileURL!)
                
            } catch {
                print("error generating csv file")
            }
        
       
        return fileURL
      
    }
   
    
    //Importing CSV
    func importCSV(_ url: URL) {
        if url.startAccessingSecurityScopedResource() {
            do {
                importText = try String(contentsOf: url)
                print( importText)
                
            } catch {
                ///DO action
                print(error.localizedDescription)
            }
        }
        url.stopAccessingSecurityScopedResource()
    }
   
    // Import function
       func uploadCSV() {
           if importText == "" {
               return
           } else {
               // split the long string into an array of "rows" of data. Each row is a string
               let rows = importText.components(separatedBy: "$$")
               
               // import player information
               let playerString = String(rows[0])
               //  print(teamString)
               var playerRows = playerString.components(separatedBy: "\n")
               
               // remove the header row
               
               playerRows.removeFirst()
               // now loop around each row and split into columns
               print("team \(playerRows)")
               
               // team
               playerViewModel.playerArray.removeAll()
               playerViewModel.savePlayer()
               
               for row in playerRows {
                   if row != ""  {
                       let csvColumns = row.components(separatedBy: ",")
                       let side = PlayerModel()
                       side.Surname = csvColumns[1]
                       side.Given = csvColumns[2]
                       side.Guernsey = Int(csvColumns[3].replacing("\r", with: "")) ?? 0
                      
                       if csvColumns[1] != "Surname" {
                           playerViewModel.addPlayer(side)
                       }
                       
                   }
               }
               // match
               
               // import match information
               let matchString = String(rows[1])
             
               var matchRows = matchString.components(separatedBy: "\n")
             
               
               // remove the header row
               matchRows.removeFirst()
               // now loop around each row and split into columns
               print("match \(matchRows)")

        matchViewModel.matchArray.removeAll()
        matchViewModel.saveMatch()
        for row in matchRows {
            if row != ""  {
                let csvColumns = row.components(separatedBy: ",")
                let game = MatchModel()
                let dateFormatter = DateFormatter()
                let dater = csvColumns[1].prefix(16)
                dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
                game.gameDate = dateFormatter.date(from:  String(dater)) ?? Date.now
                game.competition = csvColumns[2].trimmingCharacters(in: .whitespacesAndNewlines)
                game.home = csvColumns[3].trimmingCharacters(in: .whitespacesAndNewlines)
                game.homeAbbr = csvColumns[4].trimmingCharacters(in: .whitespacesAndNewlines)
                game.venue = csvColumns[5].trimmingCharacters(in: .whitespacesAndNewlines)
                game.opponent = csvColumns[6].trimmingCharacters(in: .whitespacesAndNewlines)
                game.oppAbbr = csvColumns[7].trimmingCharacters(in: .whitespacesAndNewlines)
                game.level = csvColumns[8].trimmingCharacters(in: .whitespacesAndNewlines)
                game.round = csvColumns[9].trimmingCharacters(in: .whitespacesAndNewlines)
                game.launchArray = [0]
                
                // Add unique home and away team to teamViewModel
                if teamViewModel.teamArray.contains(where: {$0.Team == csvColumns[3] }) == false {
                    let team = TeamModel()
                    team.Team = csvColumns[3]
                    team.TeamAbbr = csvColumns[4]
                    if csvColumns[1] != "gameDate" {
                        teamViewModel.addTeam(team)
                    }
                }
                if teamViewModel.teamArray.contains(where: {$0.Team == csvColumns[6] }) == false {
                    let team = TeamModel()
                    team.Team = csvColumns[6]
                    team.TeamAbbr = csvColumns[7]
                    if csvColumns[1] != "gameDate" {
                        teamViewModel.addTeam(team)
                    }
                }
                // add unique venue to venueViewModel
                if venueViewModel.venueArray.contains(where: {$0.venue == csvColumns[5]}) == false {
                    let venue = VenueModel()
                    venue.venue = csvColumns[5]
                    if csvColumns[1] != "gameDate" {
                        venueViewModel.addVenue(venue)
                    }
                }
                // add unique round to roundViewModel
                if roundViewModel.roundArray.contains(where: {$0.Round == csvColumns[9]}) == false {
                    let round = RoundModel()
                    round.Round = csvColumns[9]
                    if csvColumns[1] != "gameDate" {
                        roundViewModel.addRound(round)
                    }
                }
                // add unique level to levelViewModel
                if levelViewModel.levelArray.contains(where: {$0.Grade == csvColumns[8]}) == false {
                    let level = LevelModel()
                    level.Grade = csvColumns[8]
                    if csvColumns[1] != "gameDate" {
                        levelViewModel.addLevel(level)
                    }
                }
                // add unique competition to competitionViewModel
                if competitionViewModel.competitionArray.contains(where: {$0.competition == csvColumns[2]}) == false {
                    let competition = CompetitionModel()
                    competition.competition = csvColumns[2]
                    if csvColumns[1] != "gameDate" {
                        competitionViewModel.addCompetition(competition)
                    }
                }
                if  matchViewModel.matchArray.count > 0 {
                    matchViewModel.matchArray.removeFirst()
                }
                if csvColumns[1] != "gameDate" {
                    matchViewModel.addMatch(game)
                }
            }
           
        }
               // score
                
                // import score information
                let scoreString = String(rows[2])
                print("ss \(scoreString)")
                var scoreRows = scoreString.components(separatedBy: "\n")
                
                // remove the header row
                scoreRows.removeFirst()
                // now loop around each row and split into columns
                print("SS2 \(scoreRows)")
                
                scoreViewModel.scoreArray.removeAll()
               scoreViewModel.saveScore()
        
        for row in scoreRows {
            if row != ""  {
                let csvColumns = row.components(separatedBy: ",")
                let goalEvent = ScoreModel()
                
                goalEvent.quarter = csvColumns[1]
                goalEvent.team = csvColumns[2]
                goalEvent.scoreEvent = csvColumns[3]
                goalEvent.goalScorer = csvColumns[4]
                goalEvent.scoreType = csvColumns[5]
                goalEvent.HCWorm = Int(csvColumns[6]) ?? 0
                goalEvent.launchNummer = Int(csvColumns[7]) ?? 0
                goalEvent.typeNummer = Int(csvColumns[8]) ?? 0
                goalEvent.OpWorm = Int(csvColumns[9]) ?? 0
                
               
                if csvColumns[1] != "quarter" {
                    scoreViewModel.addScoreDetails(goalEvent)
                }
              
            }
            
        }
               // time
               // import time information
               let timeString = String(rows[3])
               //     print(timeString)
               var timeRows = timeString.components(separatedBy: "\n")
               
               // remove the header row
               timeRows.removeFirst()
               // now loop around each row and split into columns
               print(timeRows)
               
               timeViewModel.timeArray.removeAll()
               timeViewModel.saveTime()
               
               for row in timeRows {
            if row != ""  {
                let csvColumns = row.components(separatedBy: ",")
                let qtime = TimeModel()
                
                qtime.quarter = csvColumns[1]
                qtime.time = csvColumns[2]
                
                if csvColumns[1] != "quarter" {
                    timeViewModel.addTime(qtime)
                }
              
            }
        }
        
   // inputs
               // import input information
               let inputString = String(rows[4])
               // print(nputString)
               var inputRows = inputString.components(separatedBy: "\n")
               
               // remove the header row
               inputRows.removeFirst()
               // now loop around each row and split into columns
               print(inputRows)
               
        for row in inputRows {
            if row != ""  {
                let csvColumns = row.components(separatedBy: ",")
                let csvString =  csvColumns.joined(separator: ",")
                print("A.\(csvString)")
                
                switch csvColumns.first {
                case "contested":
                    contested = csvString.replacingOccurrences(of: "contested,", with: "")
                case "clearance":
                    clearance = csvString.replacingOccurrences(of: "clearance,", with: "")
                case "tackles":
                    tackles = csvString.replacingOccurrences(of: "tackles,", with: "")
                case "missedTackle":
                    missedTackle = csvString.replacingOccurrences(of: "missedTackle,", with: "")
                case "hcmarks":
                    hcmarks = csvString.replacingOccurrences(of: "hcmarks,", with: "")
                case "opmarks":
                    opmarks = csvString.replacingOccurrences(of: "opmarks,", with: "")
                case "opInside40":
                    opInside40 = csvString.replacingOccurrences(of: "opInside40,", with: "")
                case "hcInside40":
                    hcInside40 = csvString.replacingOccurrences(of: "hcInside40,", with: "")
                case "repeatS":
                    repeatS = csvString.replacingOccurrences(of: "repeatS,", with: "")
                case "spoils":
                    spoils = csvString.replacingOccurrences(of: "spoils,", with: "")
                case "pressure":
                    pressure = csvString.replacingOccurrences(of: "pressure,", with: "")
                case "chain":
                    chain = csvString.replacingOccurrences(of: "chain,", with: "")
                case "extra2":
                    extra2 = csvString.replacingOccurrences(of: "extra2,", with: "")
                case "extra4":
                    extra4 = csvString.replacingOccurrences(of: "extra4,", with: "")
                case "extra6":
                    extra6 = csvString.replacingOccurrences(of: "extra6,", with: "")
                case "defence":
                    defence = csvString.replacingOccurrences(of: "defence,", with: "")

                default:
                    print("error")
                    }
              
                }
            }
    }
        importText = ""
        completeBool.toggle()
}
 
    }

