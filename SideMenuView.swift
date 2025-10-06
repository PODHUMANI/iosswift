import SwiftUI

// A simple model for each menu row
struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let systemIcon: String
    let action: () -> Void
}

struct SideMenuView: View {
    let menuWidth: CGFloat
    let items: [MenuItem]
    let name: String
    let avatar: Image
    var body: some View {
        VStack {
            // Top area: avatar + name
            VStack(spacing: 12) {
                avatar
                    .resizable()
                    .scaledToFill()
                    .frame(width: 76, height: 76)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white.opacity(0.6), lineWidth: 2))
                    .shadow(radius: 4)
                Text(name)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding(.top, 36)
            .padding(.bottom, 12)
            .frame(maxWidth: .infinity)
            
            Divider()
                .background(Color.white.opacity(0.6))
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            
            // Menu items
            VStack(alignment: .leading, spacing: 18) {
                ForEach(items) { item in
                    Button(action: item.action) {
                        HStack(spacing: 14) {
                            Image(systemName: item.systemIcon)
                                .frame(width: 28, height: 28)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                            Text(item.title)
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .regular))
                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 14)
                }
            }
            .padding(.top, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            // Logout anchored at bottom-left
            HStack {
                Button(action: {
                    // logout action
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "arrowshape.turn.up.left")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 28)
                        Text("Log out")
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 28)
        }
        .frame(width: menuWidth)
        .background(Color(#colorLiteral(red: 0.129, green: 0.337, blue: 0.722, alpha: 1))) // deep blue like image
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView: View {
    @State private var menuOpen = true
    private let menuWidth: CGFloat = 280
    
    // Example menu items
    var menuItems: [MenuItem] {
        [
            MenuItem(title: "Profile", systemIcon: "person.crop.circle") {
                print("Profile tapped")
            },
            MenuItem(title: "Settings", systemIcon: "gearshape") {
                print("Settings tapped")
            },
            MenuItem(title: "Insurance", systemIcon: "doc.text") {
                print("Insurance tapped")
            },
            MenuItem(title: "About", systemIcon: "questionmark.circle") {
                print("About tapped")
            }
        ]
    }
    
    var body: some View {
        ZStack {
            // Background / main content
            mainAppView
                .disabled(menuOpen) // disable interactions when menu open
                .blur(radius: menuOpen ? 4 : 0)
                .offset(x: menuOpen ? menuWidth * 0.45 : 0) // small shift so blurred content visible to right
                .animation(.easeInOut(duration: 0.28), value: menuOpen)
            
            // Phone-like bezel to mimic mockup (optional styling)
            phoneFrame
            
            // Side menu (on top of phone frame)
            HStack(spacing: 0) {
                SideMenuView(menuWidth: menuWidth, items: menuItems, name: "Alice", avatar: Image(systemName: "person.crop.circle.fill"))
                    .offset(x: menuOpen ? 0 : -menuWidth - 20)
                    .animation(.interactiveSpring(response: 0.35, dampingFraction: 0.8), value: menuOpen)
                
                // The partially visible blurred content to the right of the menu
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: UIScreen.main.bounds.width - menuWidth)
                    .background(
                        // replicate the app background so it looks like blurred content peeking
                        mainPreview
                            .clipped()
                    )
                    .blur(radius: menuOpen ? 6 : 0)
                    .opacity(menuOpen ? 1 : 0)
                    .animation(.easeInOut(duration: 0.25), value: menuOpen)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .edgesIgnoringSafeArea(.all)
            
            // Menu toggle button (for demo)
            VStack {
                HStack {
                    Button(action: {
                        withAnimation { menuOpen.toggle() }
                    }) {
                        Image(systemName: menuOpen ? "xmark" : "line.horizontal.3")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.25))
                            .clipShape(Circle())
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                Spacer()
            }
        }
        .background(Color(#colorLiteral(red: 0.831, green: 0.882, blue: 0.957, alpha: 1))) // outer phone bg color
    }
    
    // Example main app view (cards / content)
    var mainAppView: some View {
        VStack {
            Text("Main App Content")
                .font(.title2)
                .padding(.top, 44)
            Spacer()
            HStack {
                Spacer()
                VStack(spacing: 14) {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 86)
                        .overlay(Text("Card 1"))
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 86)
                        .overlay(Text("Card 2"))
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 86)
                        .overlay(Text("Card 3"))
                }
                .frame(width: 200)
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
    
    // small preview of the content used to create the blurred strip to the right of menu
    var mainPreview: some View {
        VStack {
            Color.white
            Spacer()
        }
    }
    
    // Optional phone frame overlay to look like in the mockup (rounded rect with notch area)
    var phoneFrame: some View {
        RoundedRectangle(cornerRadius: 28)
            .stroke(Color.black.opacity(0.15), lineWidth: 8)
            .padding(28)
            .shadow(radius: 8)
            .allowsHitTesting(false)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
