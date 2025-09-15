import SwiftUI

struct SplashScreen: View {
    @State private var move = false
    @State private var isActive = false
    var body: some View {
        if isActive{
            WelcomeView()
        }else{
            ZStack{
                BgView()
                VStack{
                    Text("Wellcome \n To")
                        .font(.title2)
                        .opacity(0.5)
                        .multilineTextAlignment(.center)
                        .italic()
                    Spacer()
                    VStack{
                        Image(systemName: "fork.knife.circle.fill")
                            .resizable()
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius:  35))
                        Text("MyFood")
                            .foregroundStyle(LinearGradient(colors: [.blue,.black], startPoint: .top, endPoint: .bottom))
                            .italic()
                            .font(.title.lowercaseSmallCaps())
                            .fontWeight(.bold)
                        //.shadow(radius: 8)
                            .padding(.top)
                    }
                    .scaleEffect(move ? 1.5 : 1.0)
                    .animation(.linear(duration: 3).repeatForever(autoreverses: true), value: move)
                    .onAppear {
                        move.toggle()
                    }
                    //            VStack {
                    //                Image(systemName: "fork.knife.circle")
                    //                Image(systemName: "fork.knife.circle.fill")
                    //                Image(systemName: "fork.knife.circle.fill.and.cup.and.straw")
                    //                Image(systemName: "cup.and.saucer.fill")
                    //                Image(systemName: "waterbottle")
                    //                
                    //                Text("Hello, World!")
                    //            }
                    Spacer()
                }
            } .onAppear {
               DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                   withAnimation {
                       isActive = true
                   }
               }
           }
        }
    }
}

#Preview {
    SplashScreen()
}
