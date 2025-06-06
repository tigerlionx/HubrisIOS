import SwiftUI

struct ChatView: View {
    let user: User
    let professional: User
    @State private var messages: [Message] = []
    @State private var newMessage = ""

    var body: some View {
        VStack {
            ScrollView {
                ForEach(messages) { msg in
                    HStack {
                        if msg.senderId == user.id {
                            Spacer()
                            Text(msg.text)
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(10)
                        } else {
                            Text(msg.text)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                }
            }
            HStack {
                TextField("Type a message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    let message = Message(id: UUID().uuidString, senderId: user.id, text: newMessage, timestamp: Date())
                    messages.append(message)
                    newMessage = ""
                }
            }
            .padding()
        }
        .navigationTitle(professional.name)
    }
}
