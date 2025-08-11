import Foundation
import CoreData

class DataManager {
    let container = NSPersistentContainer(name: "ImageData")
    static let shared = DataManager()

    static var sharedPreview: DataManager = {
        let manager = DataManager(inMemory: true)
        let previewImage = ImageInformetion(context: manager.container.viewContext)
        previewImage.id = UUID()
        previewImage.imageName = "AppleImage"
        previewImage.favoriteValue = true
        try? manager.container.viewContext.save()
        return manager
    }()

    private init(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

import SwiftUI

struct ShowImageView: View {
    @State private var searchText = ""
    @State private var selectedImage: ImageInformetion? = nil
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: ImageInformetion.entity(), sortDescriptors: [])
    var images: FetchedResults<ImageInformetion>

    var filteredImages: [ImageInformetion] {
        if searchText.isEmpty {
            return Array(images)
        } else {
            return images.filter {
                $0.wrapedTitle.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                        ForEach(filteredImages, id: \.self) { imageItem in
                            VStack {
                                Button {
                                    selectedImage = imageItem
                                } label: {
                                    imageView(for: imageItem)
                                }
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                    delete(image: imageItem)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationDestination(item: $selectedImage) { item in
                ImageList(selectedImage: item)
            }
            .searchable(text: $searchText, prompt: "Search Image")
            .navigationTitle("Select Image")
        }
    }

    private func delete(image: ImageInformetion) {
        viewContext.delete(image)
        try? viewContext.save()
    }

    private func imageView(for imageItem: ImageInformetion) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 160, height: 160)

            VStack {
                HStack {
                    Spacer()
                    Button {
                        imageItem.wrapedFavoriteList.toggle()
                        try? viewContext.save()
                    } label: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(imageItem.favoriteValue ? .red : .white)
                            .frame(width: 30, height: 30)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .padding(.horizontal)
                    }
                }
                Image(imageItem.wrapedTitle)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Spacer()
            }
            .padding()
        }
    }
}

import SwiftUI

struct ImageList: View {
    var selectedImage: ImageInformetion

    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            VStack {
                Text(selectedImage.wrapedTitle)
                    .font(.title)
                    .padding()

                Image(selectedImage.wrapedTitle)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .navigationTitle("Image Details")
    }
}

import SwiftUI

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
                                    Image(imageItem.wrapedTitle)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                    Text(imageItem.wrapedTitle)
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

import SwiftUI

struct ContentView: View {
    @State private var isActive: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").edgesIgnoringSafeArea(.all)
                VStack {
                    TabView {
                        if isActive {
                            ShowImageView()
                                .tabItem {
                                    Label("Home", systemImage: "photo.on.rectangle.angled")
                                }
                            FavoritesView()
                                .tabItem {
                                    Label("Favorite", systemImage: "heart.fill")
                                }
                        } else {
                            ZStack {
                                Color.white.ignoresSafeArea()
                                VStack {
                                    Image(systemName: "photo.badge.magnifyingglass.fill")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.blue)
                                    Text("Welcome \n To\n PhotoApp")
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.blue)
                                        .font(.title)
                                        .padding()
                                }
                            }
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isActive = true
                            }
                        }
                    }
                }
            }
        }
    }
}
