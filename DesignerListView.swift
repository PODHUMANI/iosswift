import SwiftUI

struct DesignerListView: View {
    let designers: [Designer] = [
            Designer(name: "David Borg", title: "Flying wings", popularity: 2342, likes: 4736, followed: 136, ranking: 1, gradient: [Color.blue.opacity(0.6), Color.blue], image: "person1"),
            Designer(name: "Lucy", title: "Growing up trouble", popularity: 2342, likes: 4736, followed: 136, ranking: 2, gradient: [Color.orange.opacity(0.6), Color.orange], image: "person2"),
            Designer(name: "Jerry Cool West", title: "Sculptor's diary", popularity: 2342, likes: 4736, followed: 136, ranking: 3, gradient: [Color.pink.opacity(0.6), Color.pink], image: "person3"),
            Designer(name: "Bold", title: "Illustration of little girl", popularity: 2342, likes: 4736, followed: 136, ranking: 4, gradient: [Color.purple.opacity(0.6), Color.purple], image: "person4")
        ]

        var body: some View {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(designers) { designer in
                        DesignerCardd(designer: designer)
                    }
                }
                .padding()
            }
        }
}

#Preview {
    DesignerListView()
}
