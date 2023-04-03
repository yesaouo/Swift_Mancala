import SwiftUI

let xPos = [-320,-190,-60,65,195,325,455,325,195,65,-60,-190,-320,-450]
let yPos = [65,65,65,65,65,65,25,-65,-65,-65,-65,-65,-65,-25]
let yOff = [30,30,30,30,30,30,60,30,30,30,30,30,30,60]

struct Stone: Identifiable {
    let id = UUID()
    var hole: Int
    var index: Int
    var x: Double
    var y: Double
    var player = 0
    
    init(hole: Int) {
        self.hole = hole
        index = Int.random(in: 1...5)
        x = Double(xPos[hole] + Int.random(in: -30...30))
        y = Double(yPos[hole] + Int.random(in: -yOff[hole]...yOff[hole]))
    }
    
    mutating func moveHole(hole: Int) {
        self.hole = hole
        x = Double(xPos[hole] + Int.random(in: -30...30))
        y = Double(yPos[hole] + Int.random(in: -yOff[hole]...yOff[hole]))
    }
}
