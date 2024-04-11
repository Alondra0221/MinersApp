//
//  ContentDecision.swift
//  FirebaseYoutube
//
//  Created by Alondra García Morales on 23/01/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import Firebase
import FirebaseAuth

struct ContentDecision: View {
    @StateObject  var viewModel = FirebaseViewModel()
    
    var body: some View {
        Group {
            if viewModel.role == "Admin"{
                AdminsView()
            } else if viewModel.role == "Miner" {
                WelcomeView()
            }else{
                ProgressView()
            }
        }.onAppear {
            if let userId = Auth.auth().currentUser?.uid {
                Task {
                    await viewModel.getData(uid: userId)
                }
            } else {
                // Handle unauthenticated state or email not verified
                print("User not authenticated or email not verified.")
            }
            
        }
    }
}


