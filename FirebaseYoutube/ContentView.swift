//
//  ContentView.swift
//  FirebaseYoutube
//
//  Created by Alondra García Morales on 19/01/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import Firebase
import FirebaseAuth

struct ContentView: View {
    @StateObject var login = FirebaseViewModel()
    @EnvironmentObject var loginShow: FirebaseViewModel
    
    @State private var currentUserRole: String?
    
    var body: some View {
        Group {
            if loginShow.show {
                ContentDecision()
            } else {
                LoginView()
                
            }
        }
        .onAppear {
            if UserDefaults.standard.object(forKey: "sesion") != nil {
                loginShow.show = true
            }
        }
    }
}



