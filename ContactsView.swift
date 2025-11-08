import SwiftUI

struct ContactsView: View {
   @StateObject  var viewModel  = FirebaseFunction()
    //@StateObject  var viewModell  = GroupsChatViewModel()
    //let username = UserDefaults.standard.string(forKey:"username")
    @State var showChatView = false
    var onSelect: (ChatSummary) -> Void
    var body: some View {
        VStack {
            Text("Contacts List")
            ScrollView {
                ForEach(0..<viewModel.usernames.count, id: \.self) { index in
                    Button(action: {
                        showChatView = true
//                        let contact = ChatSummary(
//                            username: viewModel.usernames[index],
//                            email: viewModel.emails[index]
//                        )
//                        onSelect(contact)
                     //   create_api(tableName : username ,uuid: viewModel.uuids[index], name:viewModel.usernames[index],email:viewModel.emails[index],username:viewModel.usernames[index])
                    },label:  {
                    VStack(alignment: .leading, spacing: 6){
                        NavigationLink(destination: ChatView(
                            receiverEmail: viewModel.emails[index],
                            receiverName: viewModel.usernames[index]
                        )) {
                            HStack {
                                let userName = (viewModel.usernames[index])
                                    .trimmingCharacters(in: .whitespaces)
                                Text(String(userName.prefix(1)))
                                    .foregroundColor(.green)
                                    .frame(width: 60, height: 60)
                                    .background(Color.blue.opacity(0.8))
                                    .clipShape(Circle())
                                    .font(.system(size: 25, weight: .bold))
                                    .overlay(
                                        Circle().stroke(Color.black.opacity(0.6), lineWidth: 3))
                                Spacer()
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Username: \(viewModel.usernames[index])")
                                        .font(.headline)
                                        .lineLimit(2)
                                        .foregroundColor(.black)
                                    
                                    Text("Email: \(viewModel.emails[index])")
                                        .font(.subheadline)
                                        .foregroundColor(.black.opacity(0.8))
                                        .lineLimit(1)
                                }
                                Spacer()
                            }}
//                        .onTapGesture(perform: {
//                              //  create_api(tableName : username ,uuid: viewModel.uuids[index], name:viewModel.usernames[index],email:viewModel.emails[index],username:viewModel.usernames[index])
//                            })
                        .padding()} })
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(colors: [Color.teal.opacity(0.8), Color.green.opacity(0.5)],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black.opacity(0.6), lineWidth: 3))
                    .padding(.bottom)
                }
                .padding()
            }
        }
//        .navigationDestination(isPresented: $showChatView) {
//            ChatView()
//        }
    }
 
}
