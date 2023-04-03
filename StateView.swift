import SwiftUI
import AVFoundation

struct StateView: View {
    @AppStorage("computerRec") var computerRec = Data()
    @AppStorage("humanRec") var humanRec = Data()
    @State var computer: Record = Record()
    @State var human: Record = Record()
    @State var angle: Double = 0.0
    @State var isHuman = false
    @Binding var state: Bool
    func loadRecord() {
        if !computerRec.isEmpty {
            do {
                computer = try JSONDecoder().decode(Record.self, from: computerRec)
            } catch {
                print(error)
            }    
        }
        if !humanRec.isEmpty {
            do {
                human = try JSONDecoder().decode(Record.self, from: humanRec)
            } catch {
                print(error)
            }    
        }
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color(red: 0.945, green: 0.98, blue: 0.933))
            .frame(width: 440, height: 600, alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color(red: 0.1137, green: 0.2078, blue: 0.3412), lineWidth: 10))
            .overlay(alignment: .topTrailing) {
                Button {
                    AVPlayer.crossBtnPlayer.playFromStart()
                    state = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundColor(Color(red: 0.902, green: 0.224, blue: 0.275))
                        .frame(width: 30, height: 30)
                        .padding(10)
                }
            }
            .overlay(alignment: .center) {
                VStack {
                    Text("STATISTICS").foregroundColor(Color(red: 0.2706, green: 0.4824, blue: 0.6157))
                        .font(.title)
                        .bold()
                        .padding(10)
                    HStack(spacing: 0) {
                        Button(action: {isHuman = false}, label: {
                            Text("Computer")
                        }).frame(width: 120).background(isHuman ? .white : .yellow)
                        Button(action: {isHuman = true}, label: {
                            Text("Human")
                        }).frame(width: 120).background(isHuman ? .yellow : .white)
                    }.background(.white)
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            Text("綜合勝率：\(isHuman ? human.totalRate() : computer.totalRate(),specifier: "%.2f")%").bold().foregroundColor(Color(red: 0.1137, green: 0.2078, blue: 0.3412))
                            Text("先手勝率：\(isHuman ? human.firstRate() : computer.firstRate(),specifier: "%.2f")%").bold().foregroundColor(Color(red: 0.1137, green: 0.2078, blue: 0.3412))
                            Text("後手勝率：\(isHuman ? human.backRate() : computer.backRate(),specifier: "%.2f")%").bold().foregroundColor(Color(red: 0.1137, green: 0.2078, blue: 0.3412))
                        }
                        Spacer()
                        if isHuman {
                            VStack {
                                PieChartView(title: "總計", stat: human.total())
                                PieChartView(title: "先手", stat: human.first())
                                PieChartView(title: "後手", stat: human.back())
                            }
                        }else{
                            VStack {
                                PieChartView(title: "總計", stat: computer.total())
                                PieChartView(title: "先手", stat: computer.first())
                                PieChartView(title: "後手", stat: computer.back())
                            }
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            .onAppear {
                loadRecord()
            }
    }
}
