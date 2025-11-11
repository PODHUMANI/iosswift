import SwiftUI
import FirebaseAuth
struct ChatView: View {
    @State var newMessage = ""
    @Environment(SessionManager.self) var sessionMenager: SessionManager
    @State var viewModel = ChatViewModel()
    var receiverEmail: String
    var receiverName: String
    var body: some View {
        ZStack{
        VStack{
                VStack{
                    Spacer()
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .padding(.leading, 8)
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text("name")
                                    .font(.headline)
                            }
                            Text("online")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        Spacer()
                        Image(systemName: "ellipsis")
                            .font(.title2)
                            .padding(.trailing, 10)
                        //                    Button(action: {
                        //                        if viewModel.signOut() {
                        //                            sessionMenager.sessionState = .loggedOut}}) {
                        //                                Image(systemName: "iphone.and.arrow.right.outward")
                        //                                    .tint(.red)
                        //                                    .padding()
                        //                              //  Text("LogOut")
                        //                                CommonLabel(fontSize: mediumsFontSize, text: Strings.logOut, type: .Bold, fontColor: .primary)
                        //                            }
                    }
                    
                    
            } .padding()
                    .background(
                        LinearGradient(colors: [Color.teal, Color.green.opacity(0.6)],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                        .clipShape(RoundedCornerr(radius: 80, corners: [.bottomRight])))
                    .foregroundColor(.white)
                    .ignoresSafeArea()
                    .frame(height:75)
            ScrollViewReader { proxy in
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(viewModel.messages) { msg in
                            HStack {
                                if msg.sender == Auth.auth().currentUser?.email {
                                    Spacer()
                                    Text(msg.text)
                                        .padding()
                                        .background(Color.blue.opacity(0.8))
                                        .foregroundColor(.white)
                                        .cornerRadius(15)
                                        .frame(maxWidth: 250, alignment: .trailing)
                                } else {
                                    Text(msg.text)
                                        .padding()
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(15)
                                        .frame(maxWidth: 250, alignment: .leading)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(.vertical, 10)
                }.onChange(of: viewModel.messages.count) { _ in
                    if let last = viewModel.messages.last {
                        withAnimation {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }}
            HStack(spacing: 10) {
                TextField("Type your message here...", text: $newMessage)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 1)
                Button {
                    if !newMessage.isEmpty {
                        viewModel.sendMessage(to: receiverEmail, text: newMessage)
                        newMessage = ""
                    }
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.teal)
                        .clipShape(Circle())
                }
            }
            .padding()
            .background(
                LinearGradient(colors: [Color.teal.opacity(0.2), Color.white],
                               startPoint: .top,
                               endPoint: .bottom)
                .clipShape(RoundedCornerr(radius: 40, corners: [.topLeft])))
        }
        .background(Color(.systemTeal).opacity(0.15).ignoresSafeArea())
        .navigationTitle(receiverName)
        .onAppear {
            viewModel.observeMessages(with: receiverEmail)
        }
        
    }
        }
    }
