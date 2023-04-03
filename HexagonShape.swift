import SwiftUI

struct HexagonShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.width * 0.5, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.25))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height * 0.75))
        path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height * 0.75))
        path.addLine(to: CGPoint(x: 0, y: rect.height * 0.25))
        path.close()
        return Path(path.cgPath)
    }
}
