//
//  MessageField.swift
//  ChatApp-Firestore
//
//  Created by nguyen.van.quangf on 20/04/2022.
//

import SwiftUI

struct MessageField: View {
    @EnvironmentObject var messagerManager: MessageManager
    @State private var message = ""
    @State private var messageAppend = false
    var body: some View {
        HStack(spacing: 15) {
            if !messageAppend {
                HStack(spacing: 15) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "mic.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 24)
                    }
                }
                .foregroundColor(Color("Yellow"))
            } else {
                Button {
                    withAnimation(.easeInOut) {
                        messageAppend = false
                    }
                } label: {
                    Image(systemName: "chevron.forward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12)
                        .foregroundColor(Color("Yellow"))
                }
            }
            
            HStack {
                CustomTextField(placehoder: Text("Aa"), text: $message)
                
                Button {
                    
                } label: {
                    Image(systemName: "face.smiling.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color("Yellow"))
                        .padding(.vertical, 8)
                }
            }
            .padding(.horizontal, 8)
            .background(Color("Gray1"))
            .cornerRadius(50)
            
            if !messageAppend {
                Button {
                    messagerManager.sendMessage(text: "❤️")
                    message = ""
                } label: {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .foregroundColor(.red)
                        .padding(.vertical, 10)
                }
                
                
            } else {
                Button {
                    messagerManager.sendMessage(text: message)
                    message = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .foregroundColor(Color("Yellow"))
                        .padding(.vertical, 10)
                }
            }
        }
        .padding()
        .onChange(of: message) { newValue in
            print(newValue)
            if newValue.isEmpty {
                withAnimation(.easeInOut) {
                    messageAppend = false
                }
            } else {
                withAnimation(.easeInOut) {
                    messageAppend = true
                }
            }
        }
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField()
            .environmentObject(MessageManager())
    }
}

struct CustomTextField: View {
    var placehoder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placehoder
                    .opacity(0.5)
            }
            
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .foregroundColor(.white)
        }
    }
}
