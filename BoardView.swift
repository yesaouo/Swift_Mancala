import SwiftUI
import AVFoundation

struct BoardView: View {
    @AppStorage("group") var group: Int = 0
    @AppStorage("background") var background: Int = 0
    let AI: Bool
    let seq: Bool
    @State var end = false
    @State var turn = false
    @State var p1Win = false
    @State var p2Win = false
    @State var waitAnimation = false
    @State var point = [4,4,4,4,4,4,0,4,4,4,4,4,4,0]
    @State var stones = [Stone]()
    
    func reStart() {
        turn = seq
        end = false
        p1Win = false
        p2Win = false
        waitAnimation = false
        stones = []
        for i in 0...point.count-1 {
            for j in 0...point[i] {
                if j == 0 {continue}
                stones.append(Stone(hole: i))
            }
        }
        if AI && !turn { tapHole(hole: gameAI(point: point)) }
    }
    
    func getHole(hole: Int) -> [Int] {
        var inHole = [Int]()
        for (i, stone) in stones.enumerated() {
            if stone.hole == hole {
                inHole.append(i)
            }
        }
        return inHole
    }
    
    func topEnd() -> Bool {
        var sum = 0
        for i in 7...12 {
            sum += getHole(hole: i).count
        }
        return sum==0 ? true : false
    }
    func bottomEnd() -> Bool {
        var sum = 0
        for i in 0...5 {
            sum += getHole(hole: i).count
        }
        return sum==0 ? true : false
    }
    
    func checkEnd() -> Bool {
        if topEnd() {
            for i in 0...5 {
                for j in getHole(hole: i) {
                    stones[j].moveHole(hole: 6)
                }
            }
            point[6] = getHole(hole: 6).count
            point[13] = getHole(hole: 13).count
            return true
        }
        if bottomEnd() {
            for i in 7...12 {
                for j in getHole(hole: i) {
                    stones[j].moveHole(hole: 13)
                }
            }
            point[6] = getHole(hole: 6).count
            point[13] = getHole(hole: 13).count
            return true
        }
        return false
    }
    
    func updatePoint() {
        for i in 0...13 {
            point[i] = getHole(hole: i).count
        }
    }
    
    func tapHole(hole: Int) {
        if !waitAnimation {
            if (!turn && (0...5).contains(hole)) || (turn && (7...12).contains(hole)) {
                return
            }
            let inHole = getHole(hole: hole)
            if inHole.count != 0 {
                AVPlayer.picStnPlayer.playFromStart()
                waitAnimation = true
                for i in inHole {
                    stones[i].x = Double(xPos[stones[i].hole])
                    stones[i].y = Double(yPos[stones[i].hole]-50)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    var hole = hole
                    for i in inHole {
                        hole += 1
                        if (!turn && hole == 6) || (turn && hole == 13) {hole += 1}
                        if hole == 6 || hole == 13 {AVPlayer.earnPointPlayer.playFromStart()}
                        if hole == 14 {hole = 0}
                        stones[i].moveHole(hole: hole)
                    }
                    if turn && (0...5).contains(hole) && getHole(hole: hole).count == 1 {
                        let holeGet = getHole(hole: 12-hole)
                        if holeGet.count > 0 {
                            AVPlayer.earnPointPlayer.playFromStart()
                            stones[getHole(hole: hole)[0]].moveHole(hole: 6)
                            for i in holeGet {
                                stones[i].moveHole(hole: 6)
                            }
                        }
                    }
                    if !turn && (7...12).contains(hole) && getHole(hole: hole).count == 1 {
                        let holeGet = getHole(hole: 12-hole)
                        if holeGet.count > 0 {
                            AVPlayer.earnPointPlayer.playFromStart()
                            stones[getHole(hole: hole)[0]].moveHole(hole: 13)
                            for i in holeGet {
                                stones[i].moveHole(hole: 13)
                            }
                        }
                    }
                    if checkEnd() {
                        end = true
                        if point[6] > point[13] {
                            AVPlayer.winPlayer.playFromStart()
                            p1Win = true
                        }else if point[6] < point[13] {
                            AVPlayer.losePlayer.playFromStart()
                            p2Win = true
                        }
                    }
                    updatePoint()
                    waitAnimation = false
                    if !(turn && hole == 6) && !(!turn && hole == 13) {turn.toggle()}
                    if !turn && AI {tapHole(hole: gameAI(point: point))}
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            Image("Bg\(bgName[background])")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .ignoresSafeArea()
            Image("Wood")
                .resizable()
                .scaledToFill()
                .frame(width: 1080, height: 360)
                .clipShape(RoundedRectangle(cornerRadius: 50))
            HStack {
                ZStack {
                    Image("Crown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55, alignment: .center)
                        .offset(x: 0, y: -155)
                        .opacity(p2Win ? 1 : 0)
                    VStack {
                        BigHoleView(color: .blue)
                        NumHoleView(color: .blue, bgColor: .indigo, point: $point[13])
                    }
                }
                VStack {
                    HStack {
                        ForEach((0...5), id:\.self) { i in
                            SmallHoleView(color: point[12-i]>0 ? (turn ? .gray : .blue) : .gray)
                                .onTapGesture {tapHole(hole: 12-i)}
                                .overlay(alignment: .top) {
                                    Text("\(point[12-i])")
                                        .bold()
                                        .offset(x: 0, y: -20.0)
                                }
                        }
                    }
                    HStack {
                        ForEach((0...5), id:\.self) { i in
                            SmallHoleView(color: point[i]>0 ? (turn ? .yellow : .gray) : .gray)
                                .onTapGesture {tapHole(hole: i)}
                                .overlay(alignment: .bottom) {
                                    Text("\(point[i])")
                                        .bold()
                                        .offset(x: 0, y: 20.0)
                                }
                        }
                    }
                }
                ZStack {
                    Image("Crown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55, alignment: .center)
                        .offset(x: 0, y: -155)
                        .opacity(p1Win ? 1 : 0)
                    VStack {
                        NumHoleView(color: .yellow, bgColor: .orange, point: $point[6])
                        BigHoleView(color: .yellow)
                    }
                }
            }
            ForEach(stones) { stone in
                Image("\(group)\(stone.index)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 50, alignment: .center)
                    .clipShape(HexagonShape())
                    .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
                    .offset(x: stone.x, y: stone.y)
                    .animation(.easeOut, value: stone.x)
                    .animation(.easeOut, value: stone.y)
                    .onTapGesture {
                        if stone.hole != 6 && stone.hole != 13 {
                            tapHole(hole: stone.hole)
                        }
                    }
            }
        }
        .onAppear {
            reStart()
        }
        .alert(isPresented: $end) {
            Alert(title: Text(p1Win ? (AI ? "You Win!" : "Player 1 Win!") : p2Win ? (AI ? "You Lose!" : "Player 2 Win!") : "Draw"), dismissButton: .default(Text("OK")))
        }
    }
}
