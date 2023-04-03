import SwiftUI

struct SmallHoleView: View {
    let color: Color
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(RadialGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 0, opacity: 0), Color(red: 0, green: 0, blue: 0, opacity: 0.5)]), center: .center, startRadius: 5, endRadius: 100))
                .frame(width: 120, height: 120, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(color, lineWidth: 4))
        }
    }
}

struct BigHoleView: View {
    let color: Color
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(RadialGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 0, opacity: 0), Color(red: 0, green: 0, blue: 0, opacity: 0.5)]), center: .center, startRadius: 5, endRadius: 100))
                .frame(width: 120, height: 200, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(color, lineWidth: 4))
        }
    }
}

struct NumHoleView: View {
    let color: Color
    let bgColor: Color
    @Binding var point: Int
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(bgColor)
                .frame(width: 120, height: 40, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(color, lineWidth: 4))
            Text("\(point)")
                .bold()
        }
    }
}
