ZStack {
    Image("grocery_bg")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
        .blur(radius: 8)

    LinearGradient(
        gradient: Gradient(colors: [Color.white.opacity(0.6), Color.green.opacity(0.2)]),
        startPoint: .top,
        endPoint: .bottom
    )
    .ignoresSafeArea()

    VStack {
        // Your login/register content here
    }
}
