//
//  AdminsView.swift
//  FirebaseYoutube
//
//  Created by Alondra García Morales on 19/01/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct AdminsView: View {
    @StateObject var login = FirebaseViewModel()
    @EnvironmentObject var loginShow: FirebaseViewModel
    
    var body: some View {
        VStack{
            Text("Admins View").font(.title).padding(.bottom, 15)
            Text("\(login.name) \(login.lastName)").tint(.black).padding(.bottom, 15)
            Button(action:{
                try! Auth.auth().signOut()
                UserDefaults.standard.removeObject(forKey: "sesion")
                UserDefaults.standard.removeObject(forKey: "userRole")
                loginShow.show = false
            }){
                Text("Exit")
                    .foregroundStyle(.black)
                    .bold()
            }
        }.onAppear {
            if let userId = Auth.auth().currentUser?.uid {
                Task {
                    await login.getData(uid: userId)
                }
            } else {
                // Handle unauthenticated state or email not verified
                print("User not authenticated or email not verified.")
            }
            
        }
    }
}


