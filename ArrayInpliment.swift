import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    
    let fruits = ["Apple", "Banana", "Mango", "Orange", "Pineapple"]
    
    var filteredFruits: [String] {
        if searchText.isEmpty {
            return fruits
        } else {
            return fruits.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredFruits, id: \.self) { fruit in
                Text(fruit)
            }
            .navigationTitle("Fruits")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search Fruits")
        }
    }
}
