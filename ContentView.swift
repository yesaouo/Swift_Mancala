import SwiftUI
import AVFoundation

struct ContentView: View {
    @AppStorage("background") var background: Int = 0
    @State var AI = false
    @State var game = false
    @State var illu = false
    @State var set = false
    @State var state = false
    
    var body: some View {
        ZStack {
            Image("Bg\(bgName[background])")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image("Title")
                Spacer()
                HStack {
                    Button(action: {
                        AVPlayer.bigBtnPlayer.playFromStart()
                        AI = true
                        game = true
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.902, green: 0.224, blue: 0.275))
                                .frame(width: 180, height: 100, alignment: .center)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.yellow, lineWidth: 4))
                            Text("VS COMPUTER")
                                .foregroundColor(Color(red: 0.945, green: 0.98, blue: 0.933))
                                .bold()
                        }
                    })
                    Button(action: {
                        AVPlayer.bigBtnPlayer.playFromStart()
                        AI = false
                        game = true
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.6588, green: 0.8549, blue: 0.8627))
                                .frame(width: 180, height: 100, alignment: .center)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.yellow, lineWidth: 4))
                            Text("VS HUMAN")
                                .foregroundColor(Color(red: 0.945, green: 0.98, blue: 0.933))
                                .bold()
                        }
                    })
                }
                HStack {
                    Button(action: {
                        AVPlayer.bigBtnPlayer.playFromStart()
                        state = true
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.271, green: 0.482, blue: 0.616))
                                .frame(width: 180, height: 100, alignment: .center)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.yellow, lineWidth: 4))
                            Text("STATISTICS")
                                .foregroundColor(Color(red: 0.945, green: 0.98, blue: 0.933))
                                .bold()
                        }
                    })
                    Button(action: {
                        AVPlayer.bigBtnPlayer.playFromStart()
                        illu = true
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.114, green: 0.208, blue: 0.341))
                                .frame(width: 180, height: 100, alignment: .center)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.yellow, lineWidth: 4))
                            Text("HOW TO PLAY")
                                .foregroundColor(Color(red: 0.945, green: 0.98, blue: 0.933))
                                .bold()
                        }
                    })
                }
                Spacer()
            }
        }
        .overlay(alignment: .topLeading) {
            Button {
                AVPlayer.sysBtnPlayer.playFromStart()
                set = true
            } label: {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(20)
            }
        }
        .overlay(alignment: .center) {
            if set {
                SetView(set: $set)
            }
            if state {
                StateView(state: $state)
            }
        }
        .fullScreenCover(isPresented: $game) {
            PageGame(AI: $AI, game: $game)
                .overlay(alignment: .topLeading) {
                    Button {
                        AVPlayer.sysBtnPlayer.playFromStart()
                        set = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(20)
                    }
                }
                .overlay(alignment: .center) {
                    if set { SetView(set: $set) }
                }
        }
        .fullScreenCover(isPresented: $illu) {
            PageTutorial(illu: $illu)
                .overlay(alignment: .topLeading) {
                    Button {
                        AVPlayer.sysBtnPlayer.playFromStart()
                        set = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(20)
                    }
                }
                .overlay(alignment: .center) {
                    if set { SetView(set: $set) }
                }
        }
    }
}
