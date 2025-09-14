import SwiftUI

struct BgView: View {
    @State private var move = false
    var body: some View {
        Image("bgWater")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .opacity(0.8)
            .offset(x: move ? -50 : 50, y: move ? 0 : 0)
            .animation(.linear(duration: 10).repeatForever(autoreverses: true), value: move)
            .onAppear {
                move.toggle()
            }
    }
}

#Preview {
    BgView()
}
