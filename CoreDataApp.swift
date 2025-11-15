import SwiftUI

@main
struct CoreDataApp: App {
    let persistence = PersistenceController.shared

    @State private var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomeView()
                    .environment(\.managedObjectContext, persistence.container.viewContext)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
                    .environment(\.managedObjectContext, persistence.container.viewContext)
            }
        }
    }
}
