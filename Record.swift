import SwiftUI

struct Record: Identifiable, Codable {
    let id = UUID()
    var firstWin: Int = 0
    var firstLose: Int = 0
    var backWin: Int = 0
    var backLose: Int = 0
    func total() -> [Int] {
        return [firstWin+backWin,firstLose+backLose]
    }
    func first() -> [Int] {
        return [firstWin,firstLose]
    }
    func back() -> [Int] {
        return [backWin,backLose]
    }
    func totalRate() -> Double {
        if firstWin+backWin+firstLose+backLose == 0 {return 0.0}
        return Double(firstWin+backWin)/Double(firstWin+backWin+firstLose+backLose)*100
    }
    func firstRate() -> Double {
        if firstWin+firstLose == 0 {return 0.0}
        return Double(firstWin)/Double(firstWin+firstLose)*100
    }
    func backRate() -> Double {
        if backWin+backLose == 0 {return 0.0}
        return Double(backWin)/Double(backWin+backLose)*100
    }
}
