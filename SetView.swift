import SwiftUI
import AVFoundation
let moves = ["Opponent","Random","You"]
let bgName = ["Blue","Green","Yellow","Red","Pink"]
let songs = ["01. Dreaming Days","02. BLUE CLAPPER","03. 至上主義アドトラック","04. STARDUST SONG","05. 百花繚乱花吹雪","06. でいり～だいあり～！","07. 今宵はHalloween Night!","08. Suspect","09. Candy-Go-Round","10. あすいろClearSky","11. 大切フォトグラフ","12. Shiny Smily Story","13. 夢見る空へ","14. キラメキライダー☆"]

struct SetView: View {
    @AppStorage("firstMove") var firstMove: Int = 0
    @AppStorage("background") var background: Int = 0
    @AppStorage("group") var group: Int = 0
    @AppStorage("music") var music: Int = 0
    @Binding var set: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color(red: 0.945, green: 0.98, blue: 0.933))
            .frame(width: 440, height: 600, alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color(red: 0.1137, green: 0.2078, blue: 0.3412), lineWidth: 10))
            .overlay(alignment: .topTrailing) {
                Button {
                    AVPlayer.crossBtnPlayer.playFromStart()
                    set = false
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
                    Text("SETTINGS").foregroundColor(Color(red: 0.2706, green: 0.4824, blue: 0.6157))
                        .font(.title)
                        .bold()
                        .offset(x: 0, y: 10.0)
                    Spacer()
                    HStack {
                        Text("First Move").bold().foregroundColor(Color(red: 0.1137, green: 0.2078, blue: 0.3412))
                        Spacer()
                        Image(systemName: "arrowshape.left.fill")
                            .onTapGesture {
                                AVPlayer.arrowBtnPlayer.playFromStart()
                                if firstMove == -1 {firstMove = 1}
                                else {firstMove -= 1}
                            }
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150, height: 30)
                            .foregroundColor(Color(red: 0.6588, green: 0.8549, blue: 0.8627))
                            .overlay(alignment: .center) {
                                Text(moves[firstMove+1])
                                    .foregroundColor(Color(red: 0.902, green: 0.224, blue: 0.275))
                            }
                        Image(systemName: "arrowshape.right.fill")
                            .onTapGesture {
                                AVPlayer.arrowBtnPlayer.playFromStart()
                                if firstMove == 1 {firstMove = -1}
                                else {firstMove += 1}
                            }
                    }.padding(20)
                    HStack {
                        Text("Background").bold().foregroundColor(Color(red: 0.1137, green: 0.2078, blue: 0.3412))
                        Spacer()
                        Image(systemName: "arrowshape.left.fill")
                            .onTapGesture {
                                AVPlayer.arrowBtnPlayer.playFromStart()
                                if background == 0 {background = 4}
                                else {background -= 1}
                            }
                        Image("Bg\(bgName[background])")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 90)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Image(systemName: "arrowshape.right.fill")
                            .onTapGesture {
                                AVPlayer.arrowBtnPlayer.playFromStart()
                                background = (background + 1) % bgName.count
                            }
                    }.padding(20)
                    HStack {
                        Text("Group").bold().foregroundColor(Color(red: 0.1137, green: 0.2078, blue: 0.3412))
                        Spacer()
                        Image(systemName: "arrowshape.left.fill")
                            .onTapGesture {
                                AVPlayer.arrowBtnPlayer.playFromStart()
                                if group == 0 {group = 6}
                                else {group -= 1}
                            }
                        HStack(spacing: 0) {
                            Image("\(group)1").resizable().frame(width: 30, height: 30)
                            Image("\(group)2").resizable().frame(width: 30, height: 30)
                            Image("\(group)3").resizable().frame(width: 30, height: 30)
                            Image("\(group)4").resizable().frame(width: 30, height: 30)
                            Image("\(group)5").resizable().frame(width: 30, height: 30)
                        }
                        Image(systemName: "arrowshape.right.fill")
                            .onTapGesture {
                                AVPlayer.arrowBtnPlayer.playFromStart()
                                if group == 6 {group = 0}
                                else {group += 1}
                            }
                    }.padding(20)
                    HStack {
                        Text("Music").bold().foregroundColor(Color(red: 0.1137, green: 0.2078, blue: 0.3412))
                        Spacer()
                        Image(systemName: "arrowshape.left.fill")
                            .onTapGesture {
                                AVPlayer.arrowBtnPlayer.playFromStart()
                                if music == 0 {music = 13}
                                else {music -= 1}
                                guard let url = Bundle.main.url(forResource: songs[music], withExtension: "mp3") else { fatalError("Failed to find sound file.") }
                                let item = AVPlayerItem(url: url)
                                AVPlayer.bgQueuePlayer.replaceCurrentItem(with: item)
                            }
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150, height: 60)
                            .foregroundColor(Color(red: 0.6588, green: 0.8549, blue: 0.8627))
                            .overlay(alignment: .center) {
                                Text(songs[music])
                                    .foregroundColor(Color(red: 0.902, green: 0.224, blue: 0.275))
                            }
                        Image(systemName: "arrowshape.right.fill")
                            .onTapGesture {
                                AVPlayer.arrowBtnPlayer.playFromStart()
                                music = (music + 1) % songs.count
                                guard let url = Bundle.main.url(forResource: songs[music], withExtension: "mp3") else { fatalError("Failed to find sound file.") }
                                let item = AVPlayerItem(url: url)
                                AVPlayer.bgQueuePlayer.replaceCurrentItem(with: item)
                            }
                    }.padding(20)
                    Spacer()
                }
            }
    }
}
