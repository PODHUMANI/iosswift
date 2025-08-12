struct FavoritesView: View {
    @State private var searchText = ""
    @Environment(\.managedObjectContext) private var viewContext

    var fetchRequest: FetchRequest<ImageInformetion>
    var favoriteImages: FetchedResults<ImageInformetion> { fetchRequest.wrappedValue }

    init(searchText: String = "") {
        if searchText.isEmpty {
            fetchRequest = FetchRequest(
                entity: ImageInformetion.entity(),
                sortDescriptors: [],
                predicate: NSPredicate(format: "favoriteValue == true")
            )
        } else {
            fetchRequest = FetchRequest(
                entity: ImageInformetion.entity(),
                sortDescriptors: [],
                predicate: NSPredicate(format: "favoriteValue == true AND imageName CONTAINS[cd] %@", searchText)
            )
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                ScrollView {
                    if favoriteImages.isEmpty {
                        Text("No matching favorites found")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                            ForEach(favoriteImages, id: \.self) { imageItem in
                                VStack {
                                    if let uiImage = imageItem.uiImage {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                    }
                                    Text(imageItem.wrappedName)
                                }
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("Favorites")
                .searchable(text: $searchText, prompt: "Search Favorites")
            }
        }
    }
}
