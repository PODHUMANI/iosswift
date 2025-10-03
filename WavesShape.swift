import SwiftUI

struct WavesShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Starting point
        path.move(to: CGPoint(x: 0, y: rect.height * 0.7))
        
        // First wave
        path.addCurve(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.8),
                      control1: CGPoint(x: rect.width * 0.25, y: rect.height * 0.5),
                      control2: CGPoint(x: rect.width * 0.25, y: rect.height * 1.0))
        
        // Second wave
        path.addCurve(to: CGPoint(x: rect.width, y: rect.height * 0.7),
                      control1: CGPoint(x: rect.width * 0.75, y: rect.height * 0.6),
                      control2: CGPoint(x: rect.width * 0.75, y: rect.height * 0.9))
        
        // Bottom edges
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}

struct WavesView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            WavesShape()
                .fill(Color.white)
                .frame(height: 200)
                .position(x: 200, y: 600) // adjust position
        }
    }
}

struct ContentView: View {
    var body: some View {
        WavesView()
    }
}
