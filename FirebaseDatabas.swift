import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

struct ChatMessage: Identifiable ,Codable {
    let id: String
    let sender: String
//    let username : String
//    let time : String
    let text: String
//    func toDictionary() -> [String: Any] {
//    return [
//        "sender": sender,
//        "text": text
//    ]
//}
}

class GroupsChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    private var dbRef = Database.database().reference().child("chats")
    
    init() {
        fetchMessages()
    }
    func sendMessage(text: String) {
        guard let currentUser = Auth.auth().currentUser else { return }
        let key = dbRef.childByAutoId().key ?? UUID().uuidString
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
//let time = data["time"] as? String,
            //       let username = data["username"] as? String,
                   let text = data["text"] as? String {
              //      let message = ChatMessage(id: snap.key, sender: sender,username: username,time: time,text: text)
                    let message = ChatMessage(id: snap.key, sender: sender, text: text)
                    newMessages.append(message)
                }
            }
            DispatchQueue.main.async {
                self.messages = newMessages
            }
            func updateMessages(messageID:String, text : String){
                let updated: [String: Any] = [
                    "text": text
                ]
                self.dbRef.child(messageID).updateChildValues(updated)
            }
            func deleteMessage(messageID: String) {
                self.dbRef.child(messageID).removeValue()
        }
            /*do { // one data get method
             let snapshot = try await ref.child("users/\(uid)/username").getData()
             let userName = snapshot.value as? String ?? "Unknown"
           } catch {
             print(error)
           }*/
        }
    }
}
