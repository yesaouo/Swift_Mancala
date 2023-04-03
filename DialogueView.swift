import SwiftUI
import AVFoundation
let point = [[0,0,0,0,0,0,0,0,0,0,0,0,0,0],[4,4,4,4,4,4,0,4,4,4,4,4,4,0],
             [4,4,4,4,4,4,0,4,4,4,4,4,4,0],[0,2,0,0,0,0,13,0,3,10,0,0,0,20]]
let texts = ["遊戲目標: 讓靠近自己這排的右邊大洞裝滿愈多的寶石，遊戲結束時將比較雙方大洞的寶石數量。",
             "一開始每人有 24 顆寶石，一個小洞裝 4 顆。\n輪到玩家的回合時，玩家可移動自己某個小洞的寶石。\n(大洞的寶石無法移動，大洞的寶石數量代表分數）",
             "寶石將一個個逆時針移動到旁邊的洞。\n當移動的最後一顆寶石落在自己的大洞時，可以再次移動自己小洞的寶石。\n(寶石移動時不可落在對手的大洞)",
             "移動的最後一顆寶石落在自己空的小洞，而且此洞的對面也有寶石時，\n兩個洞的寶石將被收到玩家的大洞。當某一邊的小洞沒有寶石時遊戲結束，\n此時畫面上小洞的寶石也會成為分數，它們將全部移動到大洞。"]

struct DialogueView: View {
    @Binding var page: Int
    @State var text = ""
    @State var typeDone = false
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.8))
            .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.yellow, lineWidth: 10))
            .frame(width: 900, height: 200)
            .overlay {
                Text(text)
                    .foregroundColor(.white)
                    .bold()
                    .onAppear {
                        typeWriter()
                    }
            }
            .overlay(alignment: .trailing) {
                Image(systemName: "chevron.right.square.fill")
                    .resizable()
                    .frame(width: 40, height: 100, alignment: .center)
                    .foregroundColor(.orange)
                    .offset(x: -10, y: 0)
                    .opacity(!typeDone || page == point.count-1 ? 0 : 1)
                    .onTapGesture {
                        AVPlayer.arrowBtnPlayer.playFromStart()
                        page += 1
                    }
            }
            .overlay(alignment: .leading) {
                Image(systemName: "chevron.left.square.fill")
                    .resizable()
                    .frame(width: 40, height: 100, alignment: .center)
                    .foregroundColor(.orange)
                    .offset(x: 10, y: 0)
                    .opacity(!typeDone || page == 0 ? 0 : 1)
                    .onTapGesture {
                        AVPlayer.arrowBtnPlayer.playFromStart()
                        page -= 1
                    }
            }
    }
    func typeWriter(at position: Int = 0) {
        if position == 0 {
            text = ""
        }
        if position < texts[page].count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                text.append(texts[page][position])
                typeWriter(at: position + 1)
            }
        }
        if position == texts[page].count {
            typeDone = true
        }
    }
}

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
