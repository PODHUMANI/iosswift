import Foundation
import FirebaseDatabase

struct ChatMessage: Identifiable, Codable {
    var id: String
    var senderId: String
    var receiverId: String
    var text: String
    var timestamp: Double
    
    func toDictionary() -> [String: Any] {
        [
            "id": id,
            "senderId": senderId,
            "receiverId": receiverId,
            "text": text,
            "timestamp": timestamp
        ]
    }
}
import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: User? = Auth.auth().currentUser
    @Published var errorMessage = ""
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            self.user = result?.user
        }
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            self.user = result?.user
        }
    }
    
    func logout() {
        try? Auth.auth().signOut()
        self.user = nil
    }
}
import Foundation
import FirebaseDatabase
import FirebaseAuth

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    private var dbRef = Database.database().reference()
    
    func sendMessage(to receiverId: String, text: String) {
        guard let senderId = Auth.auth().currentUser?.uid else { return }
        let messageId = UUID().uuidString
        let message = ChatMessage(id: messageId, senderId: senderId, receiverId: receiverId, text: text, timestamp: Date().timeIntervalSince1970)
        
        let path = "chats/\(self.chatRoomId(senderId: senderId, receiverId: receiverId))/\(messageId)"
        dbRef.child(path).setValue(message.toDictionary())
    }
    
    func observeMessages(with userId: String) {
        guard let currentId = Auth.auth().currentUser?.uid else { return }
        let path = "chats/\(chatRoomId(senderId: currentId, receiverId: userId))"
        
        dbRef.child(path).observe(.value) { snapshot in
            var temp: [ChatMessage] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any],
                   let id = dict["id"] as? String,
                   let senderId = dict["senderId"] as? String,
                   let receiverId = dict["receiverId"] as? String,
                   let text = dict["text"] as? String,
                   let timestamp = dict["timestamp"] as? Double {
                    temp.append(ChatMessage(id: id, senderId: senderId, receiverId: receiverId, text: text, timestamp: timestamp))
                }
            }
            self.messages = temp.sorted { $0.timestamp < $1.timestamp }
        }
    }
    
    func deleteMessage(chatWith userId: String, messageId: String) {
        guard let currentId = Auth.auth().currentUser?.uid else { return }
        let path = "chats/\(chatRoomId(senderId: currentId, receiverId: userId))/\(messageId)"
        dbRef.child(path).removeValue()
    }
    
    func updateMessage(chatWith userId: String, messageId: String, newText: String) {
        guard let currentId = Auth.auth().currentUser?.uid else { return }
        let path = "chats/\(chatRoomId(senderId: currentId, receiverId: userId))/\(messageId)/text"
        dbRef.child(path).setValue(newText)
    }
    
    private func chatRoomId(senderId: String, receiverId: String) -> String {
        return senderId < receiverId ? "\(senderId)_\(receiverId)" : "\(receiverId)_\(senderId)"
    }
}
import Foundation
import FirebaseDatabase
import FirebaseAuth

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    private var dbRef = Database.database().reference()
    
    func sendMessage(to receiverId: String, text: String) {
        guard let senderId = Auth.auth().currentUser?.uid else { return }
        let messageId = UUID().uuidString
        let message = ChatMessage(id: messageId, senderId: senderId, receiverId: receiverId, text: text, timestamp: Date().timeIntervalSince1970)
        
        let path = "chats/\(self.chatRoomId(senderId: senderId, receiverId: receiverId))/\(messageId)"
        dbRef.child(path).setValue(message.toDictionary())
    }
    
    func observeMessages(with userId: String) {
        guard let currentId = Auth.auth().currentUser?.uid else { return }
        let path = "chats/\(chatRoomId(senderId: currentId, receiverId: userId))"
        
        dbRef.child(path).observe(.value) { snapshot in
            var temp: [ChatMessage] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any],
                   let id = dict["id"] as? String,
                   let senderId = dict["senderId"] as? String,
                   let receiverId = dict["receiverId"] as? String,
                   let text = dict["text"] as? String,
                   let timestamp = dict["timestamp"] as? Double {
                    temp.append(ChatMessage(id: id, senderId: senderId, receiverId: receiverId, text: text, timestamp: timestamp))
                }
            }
            self.messages = temp.sorted { $0.timestamp < $1.timestamp }
        }
    }
    
    func deleteMessage(chatWith userId: String, messageId: String) {
        guard let currentId = Auth.auth().currentUser?.uid else { return }
        let path = "chats/\(chatRoomId(senderId: currentId, receiverId: userId))/\(messageId)"
        dbRef.child(path).removeValue()
    }
    
    func updateMessage(chatWith userId: String, messageId: String, newText: String) {
        guard let currentId = Auth.auth().currentUser?.uid else { return }
        let path = "chats/\(chatRoomId(senderId: currentId, receiverId: userId))/\(messageId)/text"
        dbRef.child(path).setValue(newText)
    }
    
    private func chatRoomId(senderId: String, receiverId: String) -> String {
        return senderId < receiverId ? "\(senderId)_\(receiverId)" : "\(receiverId)_\(senderId)"
    }
}
