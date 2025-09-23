import SwiftUI

struct SearchView: View {
    let colums = [GridItem(.flexible())]
    var body: some View {
        ZStack{
            Image("foodbg")
                .resizable()
                .scaledToFill().ignoresSafeArea()
            VStack{
                Image(systemName: "slider.horizontal.3")
            
                ScrollView{
                   
                    ForEach(0..<2, id:\.self){ index in
                        ListCartViewCard()
                        
                    }
                }
            }}
    }
}

#Preview {
    SearchView()
}
