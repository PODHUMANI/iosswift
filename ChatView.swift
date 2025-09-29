struct ChatView: View {
    @StateObject var chatVM = ChatViewModel()
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            List(chatVM.messages) { msg in
                HStack {
                    if msg.sender == Auth.auth().currentUser?.email {
                        Spacer()
                        Text(msg.text)
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(10)
                    } else {
                        Text("\(msg.sender): \(msg.text)")
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        Spacer()
                    }
                }
            }
            
            HStack {
                TextField("Type a message...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Send") {
                    if !messageText.isEmpty {
                        chatVM.sendMessage(text: messageText)
                        messageText = ""
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
