//
//  LoginView.swift
//  FirebaseYoutube
//
//  Created by Alondra García Morales on 19/01/24.
//

import SwiftUI
import FirebaseFirestore

struct LoginView: View {
    
    @State private var showAlert = false
    @State private var email = ""
    @State private var pass = ""
    @StateObject var login = FirebaseViewModel()
    @EnvironmentObject var loginShow : FirebaseViewModel
    
    var body: some View {
        
        ZStack{
            Image("GreenBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack(){
                Spacer()
                Image("logo")
                    .padding(.top, -60)
                    .padding(.leading, -25)
                    
                VStack(spacing: 10){
                    HStack{
                        TextField("", text: $email, prompt: Text("Email")
                            .foregroundColor(.white))
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.none)
                        .padding(.leading,22)
                        
            
                        Image(systemName: "faceid")
                            .padding(.trailing, 22)
                    }.underlineTextField()
                        
                    HStack{
                        SecureField("", text: $pass, prompt: Text("Password")
                            .foregroundColor(.white))
                            .padding(.leading,22)
                        Image(systemName: "eye.slash").padding(.trailing, 20)

                        
                    }.underlineTextField()
                    VStack{
                        HStack{
                            RoundedRectangle(cornerRadius: 4.0)
                                .stroke(Color.white, lineWidth: 1)
                                .frame(width: 12, height: 12)
                            
                            Text("Remember me").foregroundStyle(.white).font(Font.custom("SFProDisplay-Bold", size: 14))
                        }.padding(.horizontal, -146).padding(.top, -25)
                    }
                
                    Button(action:{
                        login.login(email: email, pass: pass){ (done) in
                            if done{
                                UserDefaults.standard.set(true, forKey: "sesion")
                                loginShow.show.toggle()
                            }else{
                                showAlert = true
                            }
                        }
                        
                    }){
                        Text("LOGIN")
                            .modifier(CustomTextStyle())
                    }.modifier(CustomButtonStyle())
                    .padding(.top, 50)
                    
                    Text("FORGOT PASSWORD?")
                        .font(Font.custom("SF Pro Display", size: 14))
                        .kerning(1.05)
                        .underline()
                        .foregroundColor(.white)
                        .padding(.top, 30)
                }
                .padding()
                .padding(.top, -45)
                Spacer()
            }
        }
        
    }
}




