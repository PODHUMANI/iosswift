import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isSender: Bool
    let time: String
}

struct ChatView: View {
    @State private var newMessage = ""
    
    let messages: [ChatMessage] = [
        ChatMessage(text: "Hey! what’s the update?", isSender: false, time: "11:00AM"),
        ChatMessage(text: "Yeah, will be up in a minute.", isSender: true, time: "11:01AM"),
        ChatMessage(text: "Are you sure? I don’t see it.", isSender: false, time: "11:02AM"),
        ChatMessage(text: "Is it really today?", isSender: false, time: "11:03AM"),
        ChatMessage(text: "Well no, I think it’s not today.", isSender: true, time: "11:04AM"),
        ChatMessage(text: "Ou, I see! I was hoping ...", isSender: false, time: "11:05AM"),
        ChatMessage(text: "Yeah, me too. I really wanna see it.", isSender: true, time: "11:06AM"),
        ChatMessage(text: "I guess, we have to wait...", isSender: false, time: "11:07AM")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Header
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
                        Text("Leslie")
                            .font(.headline)
                        Image(systemName: "butterfly")
                            .foregroundColor(.blue)
                    }
                    Text("online")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()
                Image(systemName: "ellipsis")
                    .font(.title2)
                    .padding(.trailing, 10)
            }
            .padding()
            .background(
                LinearGradient(colors: [Color.teal, Color.green.opacity(0.6)],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .clipShape(RoundedCorner(radius: 50, corners: [.bottomRight]))
            )
            .foregroundColor(.white)
            
            // MARK: - Messages
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Today")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.gray)
                    
                    ForEach(messages) { message in
                        HStack {
                            if message.isSender { Spacer() }
                            VStack(alignment: message.isSender ? .trailing : .leading) {
                                Text(message.text)
                                    .padding()
                                    .foregroundColor(message.isSender ? .white : .black)
                                    .background(message.isSender ? Color.teal : Color.teal.opacity(0.2))
                                    .cornerRadius(18)
                                Text(message.time)
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                            if !message.isSender { Spacer() }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical, 10)
            }
            
            // MARK: - Input Bar
            HStack(spacing: 10) {
                TextField("Type your message here...", text: $newMessage)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 1)
                
                Button {
                    // send message logic
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
                    .clipShape(RoundedCorner(radius: 50, corners: [.topLeft]))
            )
        }
        .background(Color(.systemTeal).opacity(0.15).ignoresSafeArea())
    }
}

// MARK: - Rounded Corner Shape
struct RoundedCorner: Shape {
    var radius: CGFloat = 25.0
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    ChatView()
}
