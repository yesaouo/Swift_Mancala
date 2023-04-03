import SwiftUI

struct PieChartView: View {
    @State var isRotated = false
    let title: String
    let stat: [Int]
    let angle: Double
    init(title: String, stat: [Int]) {
        self.title = title
        self.stat = stat
        let statAverage: Double = Double(stat[0]+stat[1])/2
        angle = (Double(stat[1])-statAverage)/statAverage*180
    }
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 150, height: 150)
                .foregroundColor(.red)
            Circle()
                .trim(from: 0.25, to: 0.75)
                .frame(width: 150, height: 150)
                .foregroundColor(.teal)
            Circle()
                .trim(from: 0.25, to: 0.75)
                .frame(width: 150, height: 150)
                .foregroundColor(.red)
                .rotationEffect(Angle(degrees: isRotated ? -180+angle : -180))
                .opacity(angle>0 ? 1:0)
            Circle()
                .trim(from: 0.25, to: 0.75)
                .frame(width: 150, height: 150)
                .foregroundColor(.teal)
                .rotationEffect(Angle(degrees: isRotated ? angle : 0))
                .opacity(angle<0 ? 1:0)
            Text(title)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2)) {
                isRotated = true
            }
        }
        .overlay(alignment: .leading) {
            VStack {
                Text(" Win ")
                Text("\(stat[0])")
            }
        }
        .overlay(alignment: .trailing) {
            VStack {
                Text("Lose ")
                Text("\(stat[1])")
            }
        }
    }
}
