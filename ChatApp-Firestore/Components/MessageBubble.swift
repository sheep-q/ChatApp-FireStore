//
//  MessageBubble.swift
//  ChatApp-Firestore
//
//  Created by nguyen.van.quangf on 18/04/2022.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message
    @State private var showTime = false
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing) {
            HStack {
                Text(message.text)
                    .padding()
                    .background(message.received ? Color("MessageBG"): Color("Yellow"))
                    .cornerRadius(30)
                    .foregroundColor(.white)
                    .font(.body.bold())
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
            .onTapGesture {
                withAnimation(.easeInOut) {
                    showTime.toggle()
                }
            }
            
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(message.received ? .leading : .trailing, 25)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(message.received ? .leading : .trailing)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(id: "132", text: "I've been coding SwiftUI applicatios from scratch and it's so much fun!", received: true, timestamp: Date()))
    }
}
