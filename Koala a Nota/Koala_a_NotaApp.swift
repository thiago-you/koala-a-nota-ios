//
//  Koala_a_NotaApp.swift
//  Koala a Nota
//
//  Created by user241334 on 9/30/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      return true
  }
}

@main
struct Koala_a_NotaApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var firestoreManager = FirestoreManager()
    @State private var userStatus = UserStatus()
    
    func observeUserStatus() {
        userStatus.isLogged = Auth.auth().currentUser?.uid != nil
        
        Auth.auth().addStateDidChangeListener { auth, user in
            userStatus.isLogged = user != nil
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userStatus)
                .environmentObject(firestoreManager)
                .onAppear {
                    observeUserStatus()
                }
        }
    }
}
