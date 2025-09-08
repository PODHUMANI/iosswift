import SwiftUI
struct Designer: Identifiable {
    let id = UUID()
    let name: String
    let title: String
    let popularity: Int
    let likes: Int
    let followed: Int
    let ranking: Int
    let gradient: [Color]
    let image: String
}
struct CardSwiftUIView: View {
    let designers: [Designer] = [
        Designer(name: "David Borg", title: "Flying wings", popularity: 2342, likes: 4736, followed: 136, ranking: 1, gradient: [Color.blue.opacity(0.6), Color.blue], image: "person1"),
        Designer(name: "Lucy", title: "Growing up trouble", popularity: 2342, likes: 4736, followed: 136, ranking: 2, gradient: [Color.orange.opacity(0.6), Color.orange], image: "person2"),
        Designer(name: "Jerry Cool West", title: "Sculptor's diary", popularity: 2342, likes: 4736, followed: 136, ranking: 3, gradient: [Color.pink.opacity(0.6), Color.pink], image: "person3"),
        Designer(name: "Bold", title: "Illustration of little girl", popularity: 2342, likes: 4736, followed: 136, ranking: 4, gradient: [Color.purple.opacity(0.6), Color.purple], image: "person4")
    ]
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Designer")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    HStack(spacing: 20) {
                        Text("Category")
                        Text("Attention")
                    }
                    .font(.subheadline)
                }
                .padding()

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(designers) { designer in
                            DesignerCard(designer: designer)
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    CardSwiftUIView()
}





    
   


struct DesignerCard: View {
    let designer: Designer

    var body: some View {
        HStack {
            Image(designer.image)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.trailing, 10)

            VStack(alignment: .leading, spacing: 6) {
                Text(designer.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Title: \(designer.title)")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))

                HStack(spacing: 20) {
                    Text("\(designer.popularity)\nPopularity")
                    Text("\(designer.likes)\nLike")
                    Text("\(designer.followed)\nFollowed")
                }
                .font(.caption)
                .foregroundColor(.white.opacity(0.9))
            }

            Spacer()

            Text("\(designer.ranking)\nRanking")
                .font(.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
        }
        .padding()
        .background(LinearGradient(colors: designer.gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(20)
    }
}
