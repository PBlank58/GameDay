//
//  AddOpponentDetailView.swift
//  GameDay
//
//  Created by Brett Pullyblank on 4/1/2024.
//

import SwiftUI

struct AddMatchItemView: View {
    
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }
    
    @ObservedObject var matchViewModel: MatchViewModel
    @ObservedObject var competitionViewModel: CompetitionViewModel
    @ObservedObject var levelViewModel: LevelViewModel
    @ObservedObject var venueViewModel: VenueViewModel
    @ObservedObject var teamViewModel: TeamViewModel
    @ObservedObject var roundViewModel: RoundViewModel
    
    @State private var inputData = ""
    @State private var inputData2 = ""
    
    
    @State private var saveAlert = false
    @State private var bulkText = ""
    @State private var alertDeleteAll = false
    @State private var InputType =  "I"
    @State private var additionType = ""
    @State private var importing = false
    
    @Environment(\.dismiss) var dismiss
    
    // Sort filters for each View Model
    @State private var sortOption: SortOption = .name
    
    enum SortOption {
        case none, name
    }
    // Competition filter
    var sortedTaskCompetition: [CompetitionModel] {
        switch sortOption {
            
        case .name:
            if competitionViewModel.competitionArray.count == 0  {
                return competitionViewModel.competitionArray
            } else  {
                return competitionViewModel.competitionArray.sorted(by:  { $0.competition ==  $1.competition })
            }
        default:
            return competitionViewModel.competitionArray
        }
    }
    // Level filter
    var sortedTaskLevel: [LevelModel] {
        switch sortOption {
            
        case .name:
            if levelViewModel.levelArray.count == 0  {
                return levelViewModel.levelArray
            } else  {
                return levelViewModel.levelArray.sorted(by:  { $0.Grade ==  $1.Grade })
            }
        default:
            return levelViewModel.levelArray
        }
    }
    // Opponent filter
    var sortedTaskSchool: [TeamModel] {
        switch sortOption {
            
        case .name:
            if teamViewModel.teamArray.count == 0  {
                return teamViewModel.teamArray
            } else  {
                return teamViewModel.teamArray.sorted(by:  { $0.Team ==  $1.Team })
            }
        default:
            return teamViewModel.teamArray
        }
    }
    // Venue filter
    var sortedTaskVenue: [VenueModel] {
        switch sortOption {
            
        case .name:
            if venueViewModel.venueArray.count == 0  {
                return venueViewModel.venueArray
            } else  {
                return venueViewModel.venueArray.sorted(by:  { $0.venue ==  $1.venue })
            }
        default:
            return venueViewModel.venueArray
        }
    }
    // round filter
    var sortedTaskRound: [RoundModel] {
        switch sortOption {
            
        case .name:
            if roundViewModel.roundArray.count == 0  {
                return roundViewModel.roundArray
            } else  {
                return roundViewModel.roundArray.sorted(by:  { $0.Round ==  $1.Round })
            }
        default:
            return roundViewModel.roundArray
        }
    }
    
    
    
    var body: some View {
        Picker("Add", selection: $additionType) {
            Text("Competition").tag("Competition")
            Text("Level").tag("Level")
            Text("Team").tag("Team")
            Text("Venue").tag("Venue")
            Text("Round").tag("Round")
        }.pickerStyle(SegmentedPickerStyle())
            .padding()
        
        
        Spacer(minLength: 50)
        Picker("Input", selection: $InputType) {
            Text("Individual").tag("I")
            Text("CSV").tag("B")
        }
        .pickerStyle(.segmented)
        .background(CustomMag.HC_Mag.opacity(0.3) )
        HStack {
            Text(InputType == "I" ? "Individual entry" : "Import from CSV")
                .font(.largeTitle)
                .bold()
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            Button {
                InputType == "I" ? save() :  uploadCSV()
                inputData = ""
                inputData2 = ""
            } label: {
                Text("Upload")
                    .padding()
                    .foregroundStyle(.white)
                    .background(CustomMag.HC_Mag)
                    .clipShape(Capsule())
                    .padding()
            }
            NavigationLink
            {  AddMatchDetailsView(matchViewModel: MatchViewModel(), competitionViewModel: CompetitionViewModel(), levelViewModel: LevelViewModel(), venueViewModel: VenueViewModel(), teamViewModel: TeamViewModel(), roundViewModel: RoundViewModel()) } label: {
                Text("Return to Match Details")
                    .padding()
                    .foregroundStyle(.white)
                    .background(CustomMag.HC_Mag)
                    .clipShape(Capsule())
                    .padding()
            }
        }
        if InputType == "I" {
            HStack {
                switch additionType {
                case "Competition":
                    Text("Competition")
                case "Level":
                    Text("Level")
                case "Team":
                    Text("Team Name")
                case "Venue":
                    Text("Venue")
                case "Round":
                    Text("Round")
                default:
                    Text("Entry")
                }
                TextField("", text: $inputData)
                    .padding()
                    .background(CustomMag.HC_Mag.opacity(0.2))
                if additionType == "Team" {
                    HStack {
                        Text("Team Abbr")
                        TextField("", text: $inputData2)
                            .padding()
                            .background(CustomMag.HC_Mag.opacity(0.2))
                    }
                }
                
            }
            .padding()
            
        }
        
        else {
            // Bulk entry using csv
            Form() {
                
                HStack {
                    VStack {
                        Text("Import \(additionType) CSV")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                        switch additionType {
                        case "Competition":
                            Text("CSV format:       ID, Competition")
                                .foregroundStyle(CustomMag.HC_Mag)
                                .bold()
                        case "Level":
                            Text("CSV format:       ID, Grade")
                                .foregroundStyle(CustomMag.HC_Mag)
                                .bold()
                        case "Team":
                            Text("CSV format:       ID, Team, Abbreviation")
                                .foregroundStyle(CustomMag.HC_Mag)
                                .bold()
                        case "Venue":
                            Text("CSV format:       ID, Venue")
                                .foregroundStyle(CustomMag.HC_Mag)
                                .bold()
                        case "Round":
                            Text("CSV format:       ID, Round")
                                .foregroundStyle(CustomMag.HC_Mag)
                                .bold()
                        default:
                            Text("")
                                .foregroundStyle(CustomMag.HC_Mag)
                                .bold()
                        }
                           
                    }
                }
                Button() {
                         importing = true
                } label: {
                    Text("Select CSV File")
                        .padding()
                        .foregroundStyle(.white)
                        .background(CustomMag.HC_Mag)
                        .clipShape(Capsule())
                        .padding()
                }
                     .fileImporter(
                         isPresented: $importing,
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
            }
            
            .frame(height: 280)
        }
       Text(bulkText)
            .fixedSize(horizontal: false, vertical: true)
        
        HStack {
            VStack {
                //Competitions list
           //     Text("\(teamViewModel.teamArray.count)")
                Text("\(additionType) list")
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                switch additionType {
                case "Competition":
                    List {
                        ForEach (sortedTaskCompetition, id: \.id) {  addition in
                            Text("\(addition.competition)")
                               //.padding()
                        }
                        .onDelete(perform: deleteCompetition)
                        
                    }
                    
                case "Level":
                    List {
                        ForEach (sortedTaskLevel, id: \.id) {  addition in
                            Text("\(addition.Grade)")
                              //  .padding()
                        }
                        .onDelete(perform: deleteLevel)
                        
                    }
                    
                case "Team":
                    List {
                        ForEach (sortedTaskSchool, id: \.id) {  addition in
                            Text("\(addition.Team)  \(addition.TeamAbbr)")
                            //    .padding()
                        }
                        .onDelete(perform: deleteSchool)
                        
                    }
                    
                case "Venue":
                    List {
                        ForEach (sortedTaskVenue, id: \.id) {  addition in
                            
                            Text("\(addition.venue)")
                                //.padding()
                               
                        }
                        .onDelete(perform: deleteVenue)
                        
                    }
                    
                case "Round":
                    List {
                        ForEach (sortedTaskRound, id: \.id) {  addition in
                            
                            Text("\(addition.Round)")
                               // .padding()
                        }
                        .onDelete(perform: deleteRound)
                        
                    }
                    
                default:
                    List {
                        ForEach (sortedTaskCompetition, id: \.id) {  addition in
                            Text("Select an Item")
                                .padding()
                        }
                    }
                }
            }
        }
        
        .navigationTitle("Add \(additionType)")
        .navigationBarItems(
            trailing:
                HStack {
                    
                    ShareLink(item:generateCSV()) {
                        VStack {
                            Label("csv export", systemImage: "list.bullet.rectangle.portrait")
                                .labelStyle(.iconOnly)
                            Text("csv export")
                        }
                    }
                    
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
                .foregroundStyle(CustomMag.HC_Mag)
        )
        
        .alert(isPresented:$alertDeleteAll) {
            Alert(
                title: Text("This will clear all of the currently selected list"),
                message: Text("There is no undo"),
                primaryButton: .destructive(Text("Delete")) {
                    switch additionType {
                    case "Competition":
                        deleteCompetitionAll()
                    case "Level":
                        deleteLevelAll()
                    case "Team":
                        deleteTeamAll()
                    case "Venue":
                        deleteVenueAll()
                    case "Round":
                        deleteRoundAll()
                    default:
                        return
                    }
                },
                secondaryButton: .cancel()
            )
        }
        .alert("All fields need to be filled", isPresented: $saveAlert) {
            Button("OK", role: .cancel) { }
        }
        
    }
    
    func deleteCompetition(indexSet: IndexSet) {
        competitionViewModel.competitionArray.remove(atOffsets: indexSet )
        competitionViewModel.saveCompetition()
    }
    func deleteLevel(indexSet: IndexSet) {
        levelViewModel.levelArray.remove(atOffsets: indexSet )
        levelViewModel.saveLevel()
    }
    func deleteSchool(indexSet: IndexSet) {
        teamViewModel.teamArray.remove(atOffsets: indexSet )
        teamViewModel.saveTeam()
    }
    func deleteVenue(indexSet: IndexSet) {
        venueViewModel.venueArray.remove(atOffsets: indexSet )
        venueViewModel.saveVenue()
    }
    func deleteRound(indexSet: IndexSet) {
        roundViewModel.roundArray.remove(atOffsets: indexSet )
        roundViewModel.saveRound()
    }
    
    
    func deleteCompetitionAll() {
        competitionViewModel.competitionArray.removeAll()
        competitionViewModel.saveCompetition()
    }
    func deleteLevelAll() {
        levelViewModel.levelArray.removeAll()
        levelViewModel.saveLevel()
    }
    func deleteTeamAll() {
        teamViewModel.teamArray.removeAll()
        teamViewModel.saveTeam()
    }
    func deleteVenueAll() {
        venueViewModel.venueArray.removeAll()
        venueViewModel.saveVenue()
    }
    func deleteRoundAll() {
        roundViewModel.roundArray.removeAll()
        roundViewModel.saveRound()
    }
    
    
    
    func save() {
        if inputData == ""   {
            saveAlert = true
        } else {
            switch additionType {
            case "Competition":
                let competition = CompetitionModel()
                competition.competition = inputData
                if inputData == ""   {
                    return
                } else {
                    competitionViewModel.addCompetition(competition)
                }
            case "Level":
                let level = LevelModel()
                level.Grade = inputData
                if inputData == ""   {
                    return
                } else {
                    levelViewModel.addLevel(level)
                }
            case "Team":
                let school = TeamModel()
                school.Team = inputData
                school.TeamAbbr = inputData2
                if inputData == ""   {
                    return
                } else {
                    teamViewModel.addTeam(school)
                }
            case "Venue":
                let venue = VenueModel()
                venue.venue = inputData
                if inputData == ""   {
                    return
                } else {
                    venueViewModel.addVenue(venue)
                }
            case "Round":
                let round = RoundModel()
                round.Round = inputData
                if inputData == ""   {
                    return
                } else {
                    roundViewModel.addRound(round)
                }
            default:
                return
            }
        }
    }
    
    //Importing CSV
    func importCSV(_ url: URL) {
        if url.startAccessingSecurityScopedResource() {
            do {
                bulkText = try String(contentsOf: url)
                print(bulkText)
                
            } catch {
                ///DO action
                print(error.localizedDescription)
            }
        }
        url.stopAccessingSecurityScopedResource()
    }
    //upload function
    func uploadCSV() {
        if bulkText == "" {
            return
        } else {
            // split the long string into an array of "rows" of data. Each row is a string
            let rows = bulkText.components(separatedBy: "\n")
            // remove the header row
                
            // now loop around each row and split into columns
            print(rows)
            for row in rows {
                switch additionType {
                case "Competition":
                    if row.components(separatedBy: ",").count >= 2 {
                        let csvColumns = row.components(separatedBy: ",")
                        let competition = CompetitionModel()
                        competition.competition = csvColumns[1]
                        if  csvColumns[1] != "Competition"  || csvColumns[1].isEmpty {
                            competitionViewModel.addCompetition(competition)
                        }
                    }
                case "Level":
                    if row.components(separatedBy: ",").count >= 2 {
                        let csvColumns = row.components(separatedBy: ",")
                        let level = LevelModel()
                        level.Grade = csvColumns[1]
                        if  csvColumns[1] != "Grade"  || csvColumns[1].isEmpty {
                            levelViewModel.addLevel(level)
                        }
                    }
                case "Team":
                    if row.components(separatedBy: ",").count >= 3 {
                        print("xx \(row.components(separatedBy: ",").count - 1)")
                        let csvColumns = row.components(separatedBy: ",")
                        let school = TeamModel()
                        school.Team = csvColumns[1]
                        school.TeamAbbr = csvColumns[2]
                        if  csvColumns[1] != "Team"  || csvColumns[1].isEmpty  {
                            teamViewModel.addTeam(school)
                        }
                    }
                    
                case "Venue":
                    if row.components(separatedBy: ",").count >= 2 {
                        let csvColumns = row.components(separatedBy: ",")
                        let venue = VenueModel()
                        venue.venue = csvColumns[1]
                        if  csvColumns[1] != "Venue"  || csvColumns[1].isEmpty {
                            venueViewModel.addVenue(venue)
                        }
                    }
                case "Round":
                    if row.components(separatedBy: ",").count >= 2 {
                        let csvColumns = row.components(separatedBy: ",")
                        let round = RoundModel()
                        round.Round = csvColumns[1]
                        if  csvColumns[1] != "Round"  || csvColumns[1].isEmpty  {
                            roundViewModel.addRound(round)
                        }
                    }
                default:
                    return
                }
            }
        }
        bulkText = ""
    }
   
    func generateCSV() -> URL {
        var fileURL: URL!
        // heading of CSV file.
        
        switch additionType {
        case "Competition":
            let heading = "ID, Competition\n"
            let csvRows = competitionViewModel.competitionArray.map { "\($0.id),\($0.competition)" }
            let stringData = heading + csvRows.joined(separator: "\n")
            do {
                
                let path = try FileManager.default.url(for: .documentDirectory,
                                                       in: .allDomainsMask,
                                                       appropriateFor: nil,
                                                       create: false)
                
                fileURL = path.appendingPathComponent("Competition.csv")
                
                // append string data to file
                try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
            } catch {
                print("error generating csv file")
            }
            return fileURL
            
        case "Level":
            let heading = "ID, Grade\n"
            let csvRows = levelViewModel.levelArray.map { "\($0.id),\($0.Grade)" }
            let stringData = heading + csvRows.joined(separator: "\n")
            do {
                
                let path = try FileManager.default.url(for: .documentDirectory,
                                                       in: .allDomainsMask,
                                                       appropriateFor: nil,
                                                       create: false)
                
                fileURL = path.appendingPathComponent("Level.csv")
                
                // append string data to file
                try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
            } catch {
                print("error generating csv file")
            }
            return fileURL
            
        case "Team":
            let heading = "ID, Team, Abbr\n"
            let csvRows = teamViewModel.teamArray.map { "\($0.id),\($0.Team), \($0.TeamAbbr)" }
            let stringData = heading + csvRows.joined(separator: "\n")
            do {
                
                let path = try FileManager.default.url(for: .documentDirectory,
                                                       in: .allDomainsMask,
                                                       appropriateFor: nil,
                                                       create: false)
                
                fileURL = path.appendingPathComponent("Teams.csv")
                
                // append string data to file
                try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
            } catch {
                print("error generating csv file")
            }
            return fileURL
            
        case "Venue":
            let heading = "ID, Venue\n"
            let csvRows = venueViewModel.venueArray.map { "\($0.id),\($0.venue)" }
            let stringData = heading + csvRows.joined(separator: "\n")
            do {
                
                let path = try FileManager.default.url(for: .documentDirectory,
                                                       in: .allDomainsMask,
                                                       appropriateFor: nil,
                                                       create: false)
                
                fileURL = path.appendingPathComponent("Venue.csv")
                
                // append string data to file
                try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
            } catch {
                print("error generating csv file")
            }
            return fileURL
            
        case "Round":
            let heading = "ID, Round\n"
            let csvRows = roundViewModel.roundArray.map { "\($0.id),\($0.Round)" }
            let stringData = heading + csvRows.joined(separator: "\n")
            do {
                
                let path = try FileManager.default.url(for: .documentDirectory,
                                                       in: .allDomainsMask,
                                                       appropriateFor: nil,
                                                       create: false)
                
                fileURL = path.appendingPathComponent("Round.csv")
                
                // append string data to file
                try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
            } catch {
                print("error generating csv file")
            }
            return fileURL
            
        default:
            let heading = "ID, Round\n"
            let csvRows = roundViewModel.roundArray.map { "\($0.id),\($0.Round)" }
            let stringData = heading + csvRows.joined(separator: "\n")
            do {
                
                let path = try FileManager.default.url(for: .documentDirectory,
                                                       in: .allDomainsMask,
                                                       appropriateFor: nil,
                                                       create: false)
                
                fileURL = path.appendingPathComponent("Level.csv")
                
                // append string data to file
                try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
            } catch {
                print("error generating csv file")
            }
            return fileURL
        }

    }
    
   
}


#Preview {
    AddMatchItemView(matchViewModel: MatchViewModel(), competitionViewModel: CompetitionViewModel(), levelViewModel: LevelViewModel(), venueViewModel: VenueViewModel(), teamViewModel: TeamViewModel(), roundViewModel: RoundViewModel())
}
