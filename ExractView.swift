import SwiftUI

struct ContactsView: View {
    @StateObject private var viewModel = FirebaseFunction()
    let username = UserDefaults.standard.string(forKey: "username") ?? "Unknown"
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Contacts List")
                    .font(.largeTitle)
                    .padding()
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(0..<viewModel.usernames.count, id: \.self) { index in
                            let contactName = viewModel.usernames[index].trimmingCharacters(in: .whitespaces)
                            let contactEmail = viewModel.emails[index]
                            
                            NavigationLink(
                                destination: ChatView(
                                    receiverEmail: contactEmail,
                                    receiverName: contactName
                                )
                            ) {
                                HStack(spacing: 16) {
                                    Text(String(contactName.prefix(1)))
                                        .foregroundColor(.white)
                                        .frame(width: 60, height: 60)
                                        .background(Color.blue.opacity(0.8))
                                        .clipShape(Circle())
                                        .font(.system(size: 25, weight: .bold))
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Username: \(contactName)")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        
                                        Text("Email: \(contactEmail)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(
                                    LinearGradient(
                                        colors: [Color.teal.opacity(0.8), Color.green.opacity(0.5)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.black.opacity(0.5), lineWidth: 2)
                                )
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
