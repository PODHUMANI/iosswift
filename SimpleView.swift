ZStack {
    // Back view
    Color.blue
    
    // Middle view
    Image(systemName: "star.fill")
        .font(.system(size: 100))
        .foregroundColor(.white)
    
    // Front view
    Text("Hello SwiftUI")
        .foregroundColor(.yellow)
        .font(.title)
}
