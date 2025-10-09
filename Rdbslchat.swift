import SwiftUI
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore

// MARK: - Model
struct ChatUser: Identifiable, Codable {
    var id: String
    var senderEmail: String
    var senderName: String
    var reEmail: String
    var sendMassage: String
    var reName: String
}

// MARK: - ViewModel
class CardViewModel: ObservableObject {
    @Published var chatList: [ChatUser] = []
    private var dbRef = Database.database().reference().child("personalchats")
    
    // Fetch all messages on init
    init() {
        fetchMessage()
    }
    
    // MARK: Send Message
    func sendMessage(senderEmail: String,
                     senderName: String,
                     reEmail: String,
                     sendMassage: String,
                     reName: String) {
        
        guard !senderEmail.isEmpty, !reEmail.isEmpty, !sendMassage.isEmpty else {
            print("⚠️ Missing fields — message not sent")
            return
        }
        
        let key = dbRef.childByAutoId().key ?? UUID().uuidString
        let chat: [String: Any] = [
            "id": key,
            "senderEmail": senderEmail,
            "senderName": senderName,
            "reEmail": reEmail,          // ✅ added
            "sendMassage": sendMassage,
            "reName": reName
        ]
        
        dbRef.child(key).setValue(chat)
    }
    
    // MARK: Fetch Messages
    func fetchMessage() {
        dbRef.observe(.value) { snapshot in
            var fetched: [ChatUser] = []
            
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any] {
                    
                    let chat = ChatUser(
                        id: dict["id"] as? String ?? snap.key,
                        senderEmail: dict["senderEmail"] as? String ?? "",
                        senderName: dict["senderName"] as? String ?? "",
                        reEmail: dict["reEmail"] as? String ?? "",
                        sendMassage: dict["sendMassage"] as? String ?? "",
                        reName: dict["reName"] as? String ?? ""
                    )
                    fetched.append(chat)
                }
            }
            
            DispatchQueue.main.async {
                self.chatList = fetched
            }
        }
    }
    
    // MARK: Filter Messages Between Two Users
    func messagesBetween(senderEmail: String, receiverEmail: String) -> [ChatUser] {
        return chatList.filter {
            ($0.senderEmail == senderEmail && $0.reEmail == receiverEmail) ||
            ($0.senderEmail == receiverEmail && $0.reEmail == senderEmail)
        }
    }
}

// MARK: - Chat View
struct ChartView: View {
    @StateObject var chatVM = CardViewModel()
    @State private var messageText = ""
    @State private var senderEmail = ""
    @State private var senderName = ""
    @State private var reEmail = ""
    @State private var reName = ""
    
    var body: some View {
        ZStack {
            // Background wave (optional)
            Color.blue.opacity(0.1).ignoresSafeArea()
            
            VStack(spacing: 12) {
                VStack {
                    TextField("From Email", text: $senderEmail)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("From Name", text: $senderName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("To Email", text: $reEmail)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("To Name", text: $reName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)
                
                // Messages
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(chatVM.messagesBetween(senderEmail: senderEmail, receiverEmail: reEmail)) { msg in
                            HStack {
                                if msg.senderEmail == senderEmail {
                                    Spacer()
                                    Text(msg.sendMassage)
                                        .padding()
                                        .background(Color.blue.opacity(0.3))
                                        .cornerRadius(10)
                                } else {
                                    Text(msg.sendMassage)
                                        .padding()
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(10)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                // Input bar
                HStack {
                    TextField("Type a message...", text: $messageText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        chatVM.sendMessage(
                            senderEmail: senderEmail,
                            senderName: senderName,
                            reEmail: reEmail,
                            sendMassage: messageText,
                            reName: reName
                        )
                        messageText = ""
                    }) {
                        Image(systemName: "paperplane.fill")
                            .font(.title2)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
        }
    }
}

// MARK: - All Chats View (Home Page)
struct AllChatsView: View {
    @StateObject private var viewModel = CardViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("All Chats")
                    .font(.largeTitle.bold())
                    .padding(.top)
                
                ScrollView {
                    ForEach(viewModel.chatList) { chat in
                        NavigationLink(destination: ChartView()) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(chat.reName)
                                        .font(.headline)
                                    Text(chat.sendMassage)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ChartView()
}
