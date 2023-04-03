import SwiftUI
import AVFoundation

struct PageTutorial: View {
    @AppStorage("background") var background: Int = 0
    @Binding var illu: Bool
    @State var page: Int = 0
    var body: some View {
        ZStack {
            Image("Bg\(bgName[background])")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .ignoresSafeArea()
            VStack {
                Spacer()
                switch page {
                case 0:
                    BoardView(AI: true, seq: true, point: point[0])
                    Spacer()
                    DialogueView(page: $page)
                case 1:
                    BoardView(AI: false, seq: true, point: point[1])
                    Spacer()
                    DialogueView(page: $page)
                case 2:
                    BoardView(AI: true, seq: false, point: point[2])
                    Spacer()
                    DialogueView(page: $page)
                case 3:
                    BoardView(AI: true, seq: true, point: point[3])
                    Spacer()
                    DialogueView(page: $page)
                default:
                    BoardView(AI: true, seq: true, point: point[0])
                    Spacer()
                    DialogueView(page: $page)
                }
                Spacer()
            }
        }
        .overlay(alignment: .topTrailing) {
            Button {
                AVPlayer.sysBtnPlayer.playFromStart()
                illu = false
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(20)
            }
        }
    }
}
