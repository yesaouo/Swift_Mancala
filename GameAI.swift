import SwiftUI

func gameAI(point: [Int]) -> Int {
    let zero = point.filter { $0 == 0 }
    var hole: Int
    if point[12] == 1 {hole = 12}
    else if point[11] == 2 {hole = 11}
    else if point[10] == 3 {hole = 10}
    else if point[9] == 4 {hole = 9}
    else if point[8] == 5 {hole = 8}
    else if point[7] == 6 {hole = 7}
    else if zero.count == 0 {hole = 12}
    else if point[0] == 0 && point[12] != 0 {hole = 12}
    else if point[1] == 0 && point[11] != 0 {hole = 11}
    else if point[2] == 0 && point[10] != 0 {hole = 10}
    else if point[3] == 0 && point[9] != 0 {hole = 9}
    else if point[4] == 0 && point[8] != 0 {hole = 8}
    else if point[5] == 0 && point[7] != 0 {hole = 7}
    else if point[12] != 0 {hole = 12}
    else if point[11] != 0 {hole = 11}
    else if point[10] != 0 {hole = 10}
    else if point[9] != 0 {hole = 9}
    else if point[8] != 0 {hole = 8}
    else {hole = 7}
    
    let sorted = point[0...4].enumerated().sorted(by: {$0.element > $1.element})
    let sortedIndex = sorted.map {$0.offset}
    for i in sortedIndex {
        if point[12-i] == 0 && point[i] != 0 {
            for j in 7...11-i {
                if point[j] == 5-i {
                    hole = j
                    break
                }
            }
        }
    }
    return hole
}
