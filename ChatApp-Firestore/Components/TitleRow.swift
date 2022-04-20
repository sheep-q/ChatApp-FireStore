//
//  TitleRow.swift
//  ChatApp-Firestore
//
//  Created by nguyen.van.quangf on 18/04/2022.
//

import SwiftUI

struct TitleRow: View {
    var imageUrl = URL(string: "https://images.unsplash.com/photo-1517849845537-4d257902454a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80")
    
    var name = "Sarah Smith"
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title.bold())
                
                Text("Online")
                    .font(.caption)
//                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.white)
            
            Image(systemName: "phone.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
                .foregroundColor(Color("Yellow"))
            
            Image(systemName: "video.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 17, height: 17)
                .foregroundColor(Color("Yellow"))
        }
        .padding([.top, .horizontal])
        .padding(.bottom, 10)
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow()
            .background(Color("BG"))
    }
}
