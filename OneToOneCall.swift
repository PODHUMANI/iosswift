import FirebaseFirestore
import FirebaseAuth
import Foundation

class CallManager: ObservableObject {
    private let db = Firestore.firestore()
    @Published var incomingCall: Roomcall?

    func createCall(receiverEmail: String) {
        guard let senderEmail = Auth.auth().currentUser?.email else { return }
        let call = Roomcall(
            id: UUID().uuidString,
            room: "room_\(UUID().uuidString)",
            senderemail: senderEmail,
            receiveremail: receiverEmail
        )

        do {
            try db.collection("calls").document(call.id).setData([
                "id": call.id,
                "room": call.room,
                "senderemail": call.senderemail,
                "receiveremail": call.receiveremail
            ])
            print("✅ Call request sent")
        } catch {
            print("❌ Error creating call: \(error.localizedDescription)")
        }
    }

    func listenForIncomingCalls(currentEmail: String) {
        db.collection("calls")
            .whereField("receiveremail", isEqualTo: currentEmail)
            .addSnapshotListener { snapshot, error in
                guard let docs = snapshot?.documents else { return }
                for doc in docs {
                    if let call = try? doc.data(as: Roomcall.self) {
                        DispatchQueue.main.async {
                            self.incomingCall = call
                        }
                    }
                }
            }
    }

    func endCall(callId: String) {
        db.collection("calls").document(callId).delete { error in
            if let error = error {
                print("❌ Error ending call: \(error.localizedDescription)")
            } else {
                print("📴 Call ended successfully")
            }
        }
    }
}
