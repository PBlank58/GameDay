//
//  AddPlayerDetails.swift
//  GameDay
//
//  Created by Brett Pullyblank on 1/9/2023.
//

import SwiftUI

struct AddPlayerDetailsView: View {
    
  @StateObject var playerViewModel: PlayerViewModel = PlayerViewModel()
    @State var squadListarray = [String: String]()
    @State private var squadString = ""
    @State var  teamSelectArray: [String] = []
    @State private var counter = 1
    @State private var showList = false
    @State private var importingplayer = false
   
    let columns = [
           GridItem(.adaptive(minimum: 250), spacing:
                        0, alignment: .leading),
           ]
    
    @Environment(\.dismiss) var dismiss
    @State private var newPlayerName = ""
    
    @State private var playerSurname = ""
    @State private var playerFirstName = ""
    @State private var playerNumber = 0
    @State private var saveAlert = false
    @State private var saveBulkAlert = false
    @State private var bulkText = ""
    @State private var SurnameColumn = 3
    @State private var GivenNameColumn = 4
    @State private var NumberColumn = 5
    @State private var showTeamBool =  false
    @State private var InputType =  "I"
    @State private var alertDeleteAll = false
    
   
    //Custom Colours
    struct CustomGold {
        static let HC_Gold = Color("HC_Gold")
    }
    struct CustomMag {
        static let HC_Mag = Color("HC_Magenta")
    }
    enum SortOption {
          case none, name, number
      }
      @State private var sortOption: SortOption = .name
   
    var sortedTasks: [PlayerModel] {
              switch sortOption {
              case .number:
                      if playerViewModel.playerArray.count == 0  {
                          return playerViewModel.playerArray
                      } else  {
                          return playerViewModel.playerArray.sorted(by:  {Int($0.Guernsey)  <  Int($1.Guernsey) }
                             )
                      }
              case .name:
                      if playerViewModel.playerArray.count == 0  {
                          return playerViewModel.playerArray
                      } else  {
                          return playerViewModel.playerArray.sorted(by:  {if $0.Surname ==  $1.Surname {
                             return  $0.Given < $1.Given }
                              return $0.Surname < $1.Surname })
                      }
              default:
                  return playerViewModel.playerArray
              }
          }
    
    var body: some View {
        NavigationStack {
            Picker("Input", selection: $InputType) {
                Text("Individual").tag("I")
                Text("CSV").tag("B")
            }
            .pickerStyle(.segmented)
            Form() {
                HStack {
                    Text(InputType == "I" ? "Individual entry" : "Import from CSV")
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button {
                        InputType == "I" ? save() :  uploadCSV()
                        playerSurname = ""
                        playerFirstName = ""
                    } label: {
                        Text("Upload")
                            .padding()
                            .foregroundStyle(.white)
                            .background(CustomMag.HC_Mag)
                            .clipShape(Capsule())
                            .padding()
                    }
                    .alert("All fields need to be filled", isPresented: $saveAlert) {
                                Button("OK", role: .cancel) { }
                   
                            }
                    .alert("No data found", isPresented: $saveBulkAlert) {
                                Button("OK", role: .cancel) { }
                   
                            }
                }
                if InputType == "I" {
                    HStack {
                        Text("Surname")
                        Spacer()
                        Text("First Name")
                        Spacer()
                    }
                    .foregroundColor(.black)
                    HStack {
                        TextField("player surname", text: $playerSurname)
                        TextField("player first name", text: $playerFirstName)
                        
                    }
                    .foregroundColor(CustomMag.HC_Mag)
                    
                    HStack {
                        VStack {
                            Picker("Number", selection: $playerNumber) {
                                ForEach(0..<100) {
                                    Text("\($0)").tag($0)
                                }
                            }
                            .tint(CustomMag.HC_Mag)
                        }
                        .frame(width: 200)
                        
                    }
                } else {
                    // Bulk entry using csv
                  
                        VStack {
                            Text("Import player CSV")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                            Text("CSV format: ID, Surname, Given Name, Number")
                                .foregroundStyle(CustomMag.HC_Mag)
                                .bold()

                        }
                        
                    Button() {
                             importingplayer = true
                    } label: {
                        Text("Select CSV File")
                            .padding()
                            .foregroundStyle(.white)
                            .background(CustomMag.HC_Mag)
                            .clipShape(Capsule())
                            .padding()
                    }
                         .fileImporter(
                             isPresented: $importingplayer,
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
                    Text(bulkText)
                         .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
            .onAppear(){
                teamStringArray()
                
            }
            .navigationTitle("Input")
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
                   
                    .foregroundColor(CustomMag.HC_Mag)
            )
      
            VStack {
                Text("Selected Team")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .foregroundColor(CustomMag.HC_Mag)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Picker("Sort By", selection: $sortOption) {
                    Text("As entered").tag(SortOption.none)
                    Text("Number").tag(SortOption.number)
                    Text("Alphabetical").tag(SortOption.name)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                Toggle("Edit List or display Table", isOn: $showList)
                    .padding(.horizontal)
                    .foregroundColor(CustomMag.HC_Mag)
                    .toggleStyle(SwitchToggleStyle(tint: CustomMag.HC_Mag))
                
                if showList == true {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            
                            ForEach (sortedTasks , id: \.id) {  player in
                                HStack {
                                    Text("\(player.Guernsey) \(player.Surname), \(player.Given)")
                                }
                                .padding(.trailing)
                                .padding(.leading)
                            }
                            
                        }
                    }
                } else {
                    List {
                        
                        ForEach (sortedTasks , id: \.id) {  player in
                            HStack {
                                Text("\(player.Guernsey)   \(player.Surname), \(player.Given)")
                            }
                            .padding(.trailing)
                        }
                        .onDelete(perform: delete)
                        .onMove(perform: move)
                        
                    }
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
    
    func delete(indexSet: IndexSet) {
        playerViewModel.playerArray.remove(atOffsets: indexSet )
        playerViewModel.savePlayer()
    }
    func deleteAll() {
        playerViewModel.playerArray.removeAll()
        playerViewModel.savePlayer()
    }
    func move(indices: IndexSet, newOffset: Int) {
        playerViewModel.playerArray.move(fromOffsets: indices, toOffset: newOffset)

        }
    func save() {
        if playerSurname == "" || playerFirstName == "" || playerNumber  == 0 {
            saveAlert = true
        } else {
            let side = PlayerModel()
            side.Surname = playerSurname
            side.Given = playerFirstName
            side.Guernsey = playerNumber
          
            if playerSurname == "" || playerFirstName == "" || playerNumber  == 0 {
                return
            } else {
                playerViewModel.addPlayer(side)
            }
        }
    }
    
    func teamStringArray() {
           squadString = ""
           counter = 1
        if playerViewModel.playerArray.count == 0 {
               squadString = ""
              print("0. \(print(squadString))")
        } else  if playerViewModel.playerArray.count == 1 {
               squadString = playerViewModel.playerArray[0].Surname + ", " + playerViewModel.playerArray[0].Given + " (" + String(playerViewModel.playerArray[0].Guernsey) + ")"
             print("1. \(print(squadString))")
           } else {
              print("2. \(print(squadString))")
               while counter <= playerViewModel.playerArray.count {
                   if counter == 1 {
                       squadString = playerViewModel.playerArray[0].Surname + ", " + playerViewModel.playerArray[0].Given + " (" + String(playerViewModel.playerArray[0].Guernsey) + ")"
                     print("3. \(print(squadString))")
                       counter += 1
                   } else {
                       squadString = squadString  + "|" + playerViewModel.playerArray[counter-1].Surname + ", " + playerViewModel.playerArray[counter-1].Given + " (" + String(playerViewModel.playerArray[counter-1].Guernsey) + ")"
                      
                       counter += 1
                    print("4. \(print(squadString))")
                   }
               }
           }
           if squadString == "" {
              
           } else {
               teamSelectArray = squadString.components(separatedBy: "|").map { String($0) }
               }
       print(teamSelectArray)
       
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
            saveBulkAlert = true
        } else {
            // split the long string into an array of "rows" of data. Each row is a string
            var rows = bulkText.components(separatedBy: "\n")
            // remove the header row
            rows.removeFirst()
            // now loop around each row and split into columns
            print(rows)
                for row in rows {
                    if row != ""  {
                        // check there are the correct number of fields
                        if row.components(separatedBy: ",").count - 1 == 3 {
                         //  print(row.components(separatedBy: ",").count - 1)
                            let csvColumns = row.components(separatedBy: ",")
                            let side = PlayerModel()
                            side.Surname = csvColumns[1]
                            side.Given = csvColumns[2]
                            side.Guernsey = Int(csvColumns[3].filter({ "0"..."9" ~= $0 })) ?? 0
                            playerViewModel.addPlayer(side)
                            
                        }
                    }
        }
    }
        bulkText = ""
}
    func generateCSV() -> URL {
        var fileURL: URL!
        // heading of CSV file.
        let heading = "id, Surname, Given, Number\n"
        
        // file rows
        let csvRows = playerViewModel.playerArray.map { "\($0.id),\($0.Surname),\($0.Given),\($0.Guernsey)" }
        
        // rows to string data
        let stringData = heading + csvRows.joined(separator: "\n")
        
        do {
            
            let path = try FileManager.default.url(for: .documentDirectory,
                                                   in: .allDomainsMask,
                                                   appropriateFor: nil,
                                                   create: false)
            
            fileURL = path.appendingPathComponent("GameDay.csv")
            
            // append string data to file
            try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
            print(fileURL!)
            
        } catch {
            print("error generating csv file")
        }
        return fileURL
    }
}


struct AddPlayerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlayerDetailsView(playerViewModel: PlayerViewModel())
    }
}






