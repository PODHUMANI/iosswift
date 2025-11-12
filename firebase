import FirebaseDatabase
import FirebaseAuth

struct ChatMessage: Identifiable {
    let id: String
    let sender: String
    let text: String
}

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    private var dbRef = Database.database().reference().child("chats")
    
    init() {
        fetchMessages()
    }
    
    func sendMessage(text: String) {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let messageData: [String: Any] = [
            "sender": currentUser.email ?? "Unknown",
            "text": text
        ]
        
        dbRef.childByAutoId().setValue(messageData)
    }
    
    func fetchMessages() {
        dbRef.observe(.value) { snapshot in
            var newMessages: [ChatMessage] = []
            
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let data = snap.value as? [String: Any],
                   let sender = data["sender"] as? String,
                   let text = data["text"] as? String {
                    
                    let message = ChatMessage(id: snap.key, sender: sender, text: text)
                    newMessages.append(message)
                }
            }
            
            DispatchQueue.main.async {
                self.messages = newMessages
            }
        }
    }
}
