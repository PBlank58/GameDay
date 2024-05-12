//
//  ImportExportview.swift
//  GameDay
//
//  Created by Brett Pullyblank on 16/12/2023.
//

import SwiftUI

struct ImportExportView: View {
    
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
    @State private var importModule = false
   
   
    
    //export string for appStorage
    @State private var appStorageString = ""
    @State private var exportType = "team"
    @State private var heading = "id, Surname, first name, number"
    @State private var csvRows = [""]
    @State private var csvFileName = "team"
    @State private var csvAppStorageName = ""
 
    
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
            Text("To save Match Detail lists go to Match Details Page then \"Add List Item\" ")
        }
        Picker(selection: $exportType, label: Text("Export:")) {
            Text("Team details").tag("team")
            Text("Match details").tag("match")
            Text("Score details").tag("score")
            Text("Time details").tag("time")
            Text("Inputs").tag("inputs")
            
        }.pickerStyle(.segmented)
            .background(CustomMag.HC_Mag.opacity(0.3))
        
        Button {
            updateExport()
        } label: {
            Text("Update export options")
                .padding()
                .frame(maxWidth: 400)
                .background(Color.gray.opacity(0.6))
                .border(.gray)
                .cornerRadius(20)
                .buttonStyle(.plain)
                .font(.title)
                .foregroundColor(CustomMag.HC_Mag)
                .padding()
        }
        // only show button if export is updated
        
        
        ShareLink(item:generateModelCSV())
        {
                Text("Export csv")
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
        VStack {
            Text("Import CSV Files")
                .font(.largeTitle)
                .bold()
                .padding()
            Section {  Text("Import requires all ")
                + Text("FIVE").foregroundColor(.red) + Text(" files with the same format as exported CSVs")
            }
            .font(.title)
        }
        
        Picker(selection: $importType, label: Text("Import:")) {
            Text("Player details").tag("player")
            Text("Match details").tag("match")
            Text("Score details").tag("score")
            Text("Time details").tag("time")
            Text("Inputs").tag("inputs")
            
        }.pickerStyle(.segmented)
            .background(CustomGold.HC_Gold.opacity(0.5))
        switch importType {
        case "player":
            Text("Column headings : id, Surname, Given, Number")
        case "match":
            Text("Column headings : id, gameDate, competition, home, homeAbbr, venue, opposition, oppAbbr, level, round, launchArrray")
        case "score":
            Text("Column headings : id, quarter, team, ScoreEvent, goalScorer, scoreType, HCWorm, launchNumber, typeNumber, OpWorm")
        case "time":
            Text("Column headings : id, quarter, time")
        case "inputs":
            Text("Must be previous export from this App")
        default:
            Text("error")
        }
            // Bulk entry using csv
           
            Button() {
                importModule = true
            } label: {
                Text("Select CSV File")
                    .padding()
                    .foregroundStyle(.white)
                    .background(CustomMag.HC_Mag)
                    .clipShape(Capsule())
                    .padding()
            }
                 .fileImporter(
                     isPresented: $importModule,
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
            Text("Update Import options")
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
    func updateExport() {
        switch exportType {
        case "player":
            heading = "id, Surname, Given, Number\n"
            csvRows = playerViewModel.playerArray.map { "\($0.id),\($0.Surname),\($0.Given),\($0.Guernsey)" }
            csvFileName = "Player.csv"
        case "match":
            heading = "id, gameDate, competition, home, homeAbbr, venue, opposition, oppAbbr, level, round, launchArrray\n"
            csvRows = matchViewModel.matchArray.map { "\($0.id),\($0.gameDate),\($0.competition),\($0.home),\($0.homeAbbr),\($0.venue),\($0.opponent),\($0.oppAbbr),\($0.level),\($0.round),\($0.launchArray)" }
            csvFileName = "Match.csv"
        case "score":
            heading = "Column headings : id, quarter, team, ScoreEvent, goalScorer, scoreType, HCWorm, launchNumber, typeNumber, OpWorm\n"
            csvRows = scoreViewModel.scoreArray.map { "\($0.id),\($0.quarter),\($0.team),\($0.scoreEvent),\($0.goalScorer),\($0.scoreType),\($0.HCWorm),\($0.launchNummer),\($0.typeNummer),\($0.OpWorm)"}
            csvFileName = "Score.csv"
        case "time":
            heading = "id, quarter, time\n"
            csvRows = timeViewModel.timeArray.map { "\($0.id),\($0.quarter),\($0.time)" }
            csvFileName = "Time.csv"
        case "inputs":
            csvFileName = "Inputs.csv"
        default:
            heading = "id, Surname, Given, Number\n"
            csvRows = playerViewModel.playerArray.map { "\($0.id),\($0.Surname),\($0.Given),\($0.Guernsey)" }
            csvFileName = "Player.csv"
        }
        print(csvRows)
       
    }
        
  // create csv from updateExport function
    func generateModelCSV() -> URL {
        var fileURL: URL!
        
        if exportType == "inputs" {
            
            // heading of CSV file.
            let heading = "appStorage, data\n"
            
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
            let csvDefence = "defence" + defence + "\n"
           
            // rows to string data
            let stringData = heading
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
                
                fileURL = path.appendingPathComponent("Inputs.csv")
                
                // append string data to file
                try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
                print(fileURL!)
                
            } catch {
                print("error generating csv file")
            }
        } else {
            // rows to string data
            let stringData = heading + csvRows.joined(separator: "\n")
            
            do {
                let path = try FileManager.default.url(for: .documentDirectory,
                                                       in: .allDomainsMask,
                                                       appropriateFor: nil,
                                                       create: false)
                
                fileURL = path.appendingPathComponent(csvFileName)
                
               
                // append string data to file
                try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
                print(fileURL!)
             
            } catch {
                print("error generating csv file")
            }
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
            var rows = importText.components(separatedBy: "\n")
            // remove the header row
            // alse count the number of header columns to remove
            
            rows.removeFirst()
            // now loop around each row and split into columns
            print(rows)
            
    switch importType {
    case "player":
        playerViewModel.playerArray.removeAll()
        playerViewModel.savePlayer()
        
        for row in rows {
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
    case "match":
        matchViewModel.matchArray.removeAll()
        matchViewModel.saveMatch()
        for row in rows {
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
                    team.TeamAbbr = csvColumns[7].trimmingCharacters(in: .whitespacesAndNewlines)
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
    case "score":
        scoreViewModel.scoreArray.removeAll()
        scoreViewModel.saveScore()
        
        for row in rows {
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
    case "time":
        timeViewModel.timeArray.removeAll()
        timeViewModel.saveTime()
        
        for row in rows {
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
        
    case "inputs":
        for row in rows {
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
        
    default:
        return
        }
    }
        importText = ""
        completeBool.toggle()
}
 
    }


