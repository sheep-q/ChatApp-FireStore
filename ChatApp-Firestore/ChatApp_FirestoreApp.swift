//
//  ChatApp_FirestoreApp.swift
//  ChatApp-Firestore
//
//  Created by nguyen.van.quangf on 18/04/2022.
//

import SwiftUI
import Firebase

@main
struct ChatApp_FirestoreApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
