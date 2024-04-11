//
//  FirebaseViewModel.swift
//  FirebaseYoutube
//
//  Created by Alondra García Morales on 19/01/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import Firebase
import FirebaseAuth


class FirebaseViewModel : ObservableObject{
    
    @Published var show = false
    
    //variables firebase
    @Published var id = ""
    @Published var name = "" {
        didSet {
            print("Name updated: \(name)")
        }
    }
    @Published var lastName = "" {
        didSet {
            print("Last Name updated: \(lastName)")
        }
    }
    @Published var role = "" {
        didSet {
            print("Role updated: \(role)")
        }
    }
    enum CustomError: Error {
            case authError(String)
            case dataError(String)
    }
    
    func login(email: String, pass: String, completion: @escaping (_ done: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { authResult, error in
            if let user = authResult?.user {
                print(user.uid)
                print("entro")
                DispatchQueue.main.async {
                    self.id = user.uid
                    completion(true)
                }
            } else {
                if let error = error?.localizedDescription {
                    DispatchQueue.main.async {
                        print("Error in firebase: \(error)")
                    }
                } else {
                    DispatchQueue.main.async {
                        print("Unknown error in firebase: \(error?.localizedDescription ?? "")")
                    }
                }
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    func getData(uid: String) async {
        do {
            let db = Firestore.firestore()
            let usuarioRef = db.collection("usuarios").document(uid)
            
            let document = try await usuarioRef.getDocument()
            
            if document.exists {
                let valor = document.data()
                let name = valor?["name"] as? String ?? "sin texto"
                let lastName = valor?["lastName"] as? String ?? "sin texto"
                let tipoUsuario = valor?["role"] as? String ?? "sin texto"
                DispatchQueue.main.async {
                    self.name = name
                    self.lastName = lastName
                    self.role = tipoUsuario
                }
                /*if let tipoUsuario = document.data()?["role"] as? String {
                    DispatchQueue.main.async {
                        self.role = tipoUsuario
                    }
                } else {
                    throw CustomError.dataError("Role is nil or not a string")
                }*/
            } else {
                throw CustomError.dataError("Document does not exist")
            }
        } catch {
            DispatchQueue.main.async {
                print("Error fetching user information: \(error.localizedDescription)")
            }
        }
    }
}



