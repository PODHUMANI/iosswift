@main
struct MyApp: App {
    @AppStorage("loginState") var loginState: LoginState = .loggedOut

    @ViewBuilder
    var rootView: some View {
        switch loginState {
        case .loggedOut: LoginView()
        case .loggedIn: HomeView()
        }
    }

    var body: some Scene {
        WindowGroup {
            rootView
        }
    }
}
