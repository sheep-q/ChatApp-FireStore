//
//  ContentView.swift
//  ChatApp-Firestore
//
//  Created by nguyen.van.quangf on 18/04/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var messageManager = MessageManager()
    
    var messageArray = ["Hello", "How are you today", "I've been building SwiftUI applications from scratch and it's so much fun!"]
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 2) {
                            ForEach(messageManager.messages, id: \.id) { message in
                                MessageBubble(message: Message(id: message.id, text: message.text, received: message.received, timestamp: message.timestamp))
                            }
                        }
                        .padding(.top, 85)
                        .onChange(of: messageManager.lastMessageId) { id in
                            withAnimation(.easeInOut) {
                                proxy.scrollTo(id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 75)
                
                TitleRow()
            }
            
            MessageField()
                .environmentObject(messageManager)
        }
        .background(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct AdaptsToKeyboard: ViewModifier {
    @State var currentHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.currentHeight)
                .onAppear(perform: {
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
                        .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
                        .compactMap { notification in
                            withAnimation(.easeOut(duration: 0.16)) {
                                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                            }
                    }
                    .map { rect in
                        rect.height - geometry.safeAreaInsets.bottom
                    }
                    .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                    
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
                        .compactMap { notification in
                            CGFloat.zero
                    }
                    .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                })
        }
    }
}

extension View {
    func adaptsToKeyboard() -> some View {
        return modifier(AdaptsToKeyboard())
    }
}
