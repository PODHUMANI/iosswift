 import SwiftUI

struct gemery: View {
    var body: some View {
        GeometryReader (content: {
            geometry in
            VStack{
                HStack(spacing:10){
                    Image("Image")
                        .resizable()
                        .frame(width:geometry.size
                            .width/2)
                        .border(Color.red)
                    Text("Hello, World!")
                        .frame(width:geometry.size
                            .width/2)
                        .border(Color.red)
                }
                Spacer()
            }
            .border(Color.blue)
        })
        
        
    }
}

#Preview {
    gemery()
}
