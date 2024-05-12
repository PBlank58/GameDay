import SwiftUI

struct BodyTimer: View {
    
   
    @StateObject var timeViewModel: TimeViewModel = TimeViewModel()
    
    @Environment(\.dismiss) var dismiss
    //Custom Colours
    struct CustomGold { static let HC_Gold = Color("HC_Gold")  }
    struct CustomMag { static let HC_Mag = Color("HC_Magenta") }
    
   // Disable appropriate buttons
    @AppStorage("startBool") var startBool = true
    @AppStorage("stopBool") var stopBool = false
    @State private var alertEndQuarter = false
    
    @State private var Alertmessage: String = ""
    @State private var quarter = "1"
    @State private var qlength = "0:00"
    @State var startTime: Date?
    @State var startDelay: Date?
   
    @Binding var quarterInt: Int
    
    // timer
    @State var  timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeElapsed: Int?
    
    
    //convert  time as Integer to minutes and seconds display
    func convertSeconds(timeInSeconds:  Int) ->
    String {
        let minutes = timeInSeconds / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Button("Start") {
                        startTime = Date.now
                        saveStartTime()
                        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                        startBool = false
                        stopBool = true
                        print("Button \(String(describing: startTime))")

                    }
                    .foregroundColor(!stopBool ? CustomMag.HC_Mag : .gray)
                    .disabled(startBool == false)
                    .padding(.horizontal)
                   
                    Button("End") {
                        alertEndQuarter.toggle()
                        startBool = true
                        stopBool = false
                    }
                    .foregroundColor(stopBool ? CustomMag.HC_Mag : .gray)
                    .disabled(stopBool == false)
                }
             
                // actual time gone display
                // MARK: change out 60 for delay time as ai integer
                Text(convertSeconds(timeInSeconds: timeElapsed ?? 0))
                   .font(.system(size: 25))
                   .padding(10)

                    .onReceive(timer) { firedTime in
                  if  stopBool == true {
                            timeElapsed = Int(firedTime.timeIntervalSince(startTime ?? Date.now))
                      } else {
                          return
                       }
                }
            }
        }
        .border(CustomMag.HC_Mag)

      
        .onAppear {
        startTime = fetchStartTime()
            print("Appear \(String(describing: startTime))")
        }
                .onDisappear {
                    print("Disappear \(String(describing: startTime))")
             
                }
                .alert(isPresented:$alertEndQuarter) {
                    Alert(
                        title: Text("Finish Quarter \(quarterInt)"),
                        message: Text(""),
                        primaryButton: .default(Text("Save")) {
                            deleteQuarter()
                            startTime = Date.now
                            saveStartTime()
                            timer.upstream.connect().cancel()
                            startBool = true
                            stopBool = false
                            timeViewModel.saveTime()
                            qlength = convertSeconds(timeInSeconds: timeElapsed ?? 0)
                            save()
                        },
                        secondaryButton: .cancel()
                    )
                }
       
    }
    func deleteQuarter() {
        
        if let qIndex = timeViewModel.timeArray.firstIndex(where: { $0.quarter == String(quarterInt) }) {
            timeViewModel.timeArray.remove(at: qIndex) }
        timeViewModel.saveTime()
    }
    
    func save() {
        let qtime = TimeModel()
        qtime.quarter =  String(quarterInt)
        qtime.time = qlength
       timeViewModel.addTime(qtime)
     
    }
    func saveStartTime() {
        if let startTime = startTime {
            UserDefaults.standard.set(startTime, forKey: "startTime")
        } else {
            UserDefaults.standard.removeObject(forKey: "startTime")
        }
    }
    func fetchStartTime() -> Date? {
        UserDefaults.standard.object(forKey: "startTime") as? Date
    }
}


struct BodyTimer_Previews: PreviewProvider {
    static var previews: some View {
        BodyTimer(quarterInt: .constant(1))
           
    }
}
