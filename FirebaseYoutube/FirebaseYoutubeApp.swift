//
//  FirebaseYoutubeApp.swift
//  FirebaseYoutube
//
//  Created by Alondra García Morales on 19/01/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct FirebaseYoutubeApp: App {
    
    // register app delegate for Firebase setup
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        let login = FirebaseViewModel()
        
        WindowGroup {
            ContentView().environmentObject(login)
        }
    }
}
