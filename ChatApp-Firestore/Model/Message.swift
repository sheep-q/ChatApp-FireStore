//
//  Message.swift
//  ChatApp-Firestore
//
//  Created by nguyen.van.quangf on 18/04/2022.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
