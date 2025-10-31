import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseAuth

struct Message: Identifiable, Codable {
    var id: String
    var senderId: String
    var text: String
    var timestamp: TimeInterval
}

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var newMessage: String = ""
    
    var chatId: String
    
    init(currentUserId: String, otherUserId: String) {
        self.chatId = [currentUserId, otherUserId].sorted().joined(separator: "_")
        fetchMessages()
    }
    
    func fetchMessages() {
        Database.database().reference()
            .child("chats")
            .child(chatId)
            .child("messages")
            .observe(.value) { snapshot in
                var temp: [Message] = []
                for child in snapshot.children {
                    if let snap = child as? DataSnapshot,
                       let dict = snap.value as? [String: Any],
                       let senderId = dict["senderId"] as? String,
                       let text = dict["text"] as? String,
                       let timestamp = dict["timestamp"] as? Double {
                        temp.append(Message(id: snap.key, senderId: senderId, text: text, timestamp: timestamp))
                    }
                }
                self.messages = temp.sorted(by: { $0.timestamp < $1.timestamp })
            }
    }
    
    func sendMessage(currentUserId: String) {
        guard !newMessage.isEmpty else { return }
        let ref = Database.database().reference()
            .child("chats")
            .child(chatId)
            .child("messages")
            .childByAutoId()
        
        let messageData = [
            "senderId": currentUserId,
            "text": newMessage,
            "timestamp": ServerValue.timestamp()
        ] as [String : Any]
        
        ref.setValue(messageData)
        newMessage = ""
    }
    
    func forwardMessage(_ message: Message, toUserId: String) {
        guard let currentUser = Auth.auth().currentUser else { return }
        let newChatId = [currentUser.uid, toUserId].sorted().joined(separator: "_")
        let ref = Database.database().reference()
            .child("chats")
            .child(newChatId)
            .child("messages")
            .childByAutoId()
        
        let newMessage = [
            "senderId": currentUser.uid,
            "text": "📩 Forwarded: \(message.text)",
            "timestamp": ServerValue.timestamp()
        ] as [String : Any]
        
        ref.setValue(newMessage)
    }
}

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    @State var currentUserId: String
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages) { message in
                    HStack {
                        if message.senderId == currentUserId {
                            Spacer()
                            messageBubble(message.text, isCurrentUser: true)
                                .contextMenu {
                                    Button("Forward") {
                                        // Example: forward to another user
                                        viewModel.forwardMessage(message, toUserId: "user2")
                                    }
                                }
                        } else {
                            messageBubble(message.text, isCurrentUser: false)
                                .contextMenu {
                                    Button("Forward") {
                                        viewModel.forwardMessage(message, toUserId: "user1")
                                    }
                                }
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                }
            }
            HStack {
                TextField("Message...", text: $viewModel.newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    viewModel.sendMessage(currentUserId: currentUserId)
                }) {
                    Image(systemName: "paperplane.fill")
                }
            }
            .padding()
        }
        .navigationTitle("Chat")
    }
    
    func messageBubble(_ text: String, isCurrentUser: Bool) -> some View {
        Text(text)
            .padding()
            .background(isCurrentUser ? Color.blue.opacity(0.7) : Color.gray.opacity(0.3))
            .cornerRadius(12)
            .foregroundColor(.white)
    }
}
