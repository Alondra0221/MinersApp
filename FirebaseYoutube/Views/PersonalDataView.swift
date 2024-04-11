//
//  PersonalDataView.swift
//  FirebaseYoutube
//
//  Created by Alondra García Morales on 31/01/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import MyLibraryHealthKit
import MyLibraryViewModelAltitud
struct PersonalDataView: View {
    
    @StateObject var login = FirebaseViewModel()
    @StateObject private var viewModel1 = viewModelHealthKit()
    @StateObject private var locationViewModel = viewModelAltitud()
    @EnvironmentObject var loginShow: FirebaseViewModel
    var body: some View {
        
        ZStack{
            Image("GreenBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
          
            VStack{
                VStack(){
                    VStack(alignment: .center){
                        Image(systemName: "person").foregroundStyle(.gray)
                            .frame(width: 95, height: 95)
                            .background(
                                Circle()
                                    .fill(Color.white)
                            )
                        Text("\(login.name) \(login.lastName) ")
                            .font(
                                Font.custom("SF Pro Display", size: 25)
                                    .weight(.bold)
                            )
                            .foregroundStyle(Color("GreenButton"))
                            .padding(.top,20)
                            .padding(.bottom, 40)
                    }.padding(.top, -30)
                    
                    
                    VStack(alignment:.leading, spacing: 12){
                        
                        HStack(){
                            VStack(alignment:.leading, spacing:12){
                                Text("AGE: ").font(
                                    Font.custom("SF Pro Display", size: 14)
                                        .weight(.bold)
                                )
                                .foregroundStyle(.white)
                                Text("GROUP: ").font(
                                    Font.custom("SF Pro Display", size: 14)
                                        .weight(.bold)
                                )
                                .foregroundStyle(.white)
                                Text("SHIFT: ").font(
                                    Font.custom("SF Pro Display", size: 14)
                                        .weight(.bold)
                                )
                                .foregroundStyle(.white)
                                Text("AREA: ").font(
                                    Font.custom("SF Pro Display", size: 14)
                                        .weight(.bold)
                                )
                                .foregroundStyle(.white)
                                Text("ROLE POSITION ").font(
                                    Font.custom("SF Pro Display", size: 14)
                                        .weight(.bold)
                                )
                                .foregroundStyle(.white)
                            }.padding(.leading, -20)
                            
                            
                            VStack(alignment:.leading, spacing: 12){
                                Text("\(viewModel1.age) Years old").font(
                                    Font.custom("SF Pro Display", size: 12)
                                )
                                .foregroundStyle(.white)
                                Text("Lion").font(
                                    Font.custom("SF Pro Display", size: 12)
                                )
                                .foregroundStyle(.white)
                                Text("Day").font(
                                    Font.custom("SF Pro Display", size: 12)
                                )
                                .foregroundStyle(.white)
                                Text("Black ridge").font(
                                    Font.custom("SF Pro Display", size: 12)
                                )
                                .foregroundStyle(.white)
                                Text("Driller").font(
                                    Font.custom("SF Pro Display", size: 12)
                                )
                                .foregroundStyle(.white)
                                
                            }.padding(.leading, 42)
                        }.padding(.leading, 75)
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 1)
                            .background(Color(red: 0.74, green: 0.73, blue: 0.73))
                            .padding(20)
                        
                            
                        VStack{
                            Text("ROLE POSITION HISTORY:").font(
                                Font.custom("SF Pro Display", size: 14)
                                    .weight(.bold)
                            )
                            .foregroundStyle(.white)
                        }.padding(.leading, 44).padding(.bottom,9)
                        HStack(){
                            VStack(alignment:.leading, spacing:12){
                                
                                Text("DRILLER:").font(
                                    Font.custom("SF Pro Display", size: 14)
                                        .weight(.bold)
                                ).foregroundStyle(.white)
                                
                                Text("SUPERVISOR:").font(
                                    Font.custom("SF Pro Display", size: 14)
                                        .weight(.bold)
                                ).foregroundStyle(.white)
                            }.padding(.leading, -20)
                            
                        
                            VStack(alignment:.leading, spacing: 12){
                               
                                Text("Sep 23, present").font(
                                    Font.custom("SF Pro Display", size: 12)
                                        .weight(.bold)
                                ).foregroundStyle(.white)
                                
                                Text("Jun 23 - May 23").font(
                                    Font.custom("SF Pro Display", size: 12)
                                        .weight(.bold)
                                ).foregroundStyle(.white)
                                
                            }.padding(.leading, 58)
                        }.padding(.leading, 75)
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 1)
                            .background(Color(red: 0.74, green: 0.73, blue: 0.73))
                            .padding(20)
                        VStack{
                            Text("GROUP HISTORY:").font(
                                Font.custom("SF Pro Display", size: 14)
                                    .weight(.bold)
                            )
                            .foregroundStyle(.white)
                        }.padding(.leading, 44).padding(.bottom,9)
                        HStack(){
                            VStack(alignment:.leading, spacing:12){
                                
                                
                                Text("LION").font(
                                    Font.custom("SF Pro Display", size: 14)
                                        .weight(.bold)
                                ).foregroundStyle(.white)
                                
                                Text("PANTHER").font(
                                    Font.custom("SF Pro Display", size: 14)
                                        .weight(.bold)
                                ).foregroundStyle(.white)
                                
                            }.padding(.leading, -20)
                            
                        
                            VStack(alignment:.leading, spacing: 12){
                                Text("Sep 23, present").font(
                                    Font.custom("SF Pro Display", size: 12)
                                        .weight(.bold)
                                ).foregroundStyle(.white)
                                
                                Text("Jun 23 - May 23").font(
                                    Font.custom("SF Pro Display", size: 12)
                                        .weight(.bold)
                                ).foregroundStyle(.white)
                            }.padding(.leading, 89)
                        }.padding(.leading, 75)

                    }
                    
                }
                
                    Button(action:{
                        try! Auth.auth().signOut()
                        UserDefaults.standard.removeObject(forKey: "sesion")
                        UserDefaults.standard.removeObject(forKey: "userRole")
                        loginShow.show = false
                    }){
                        Text("LOGOUT")
                            .modifier(CustomTexLogouttStyle())
                    }.modifier(CustomButtonLogutStyle())
                    .padding(.bottom, -50)
                    .padding(.top, 40)
                        
            
            }.CardViewPersonalData()
        }.onAppear {
            if let userId = Auth.auth().currentUser?.uid {
                Task {
                    await login.getData(uid: userId)
                    viewModel1.getAge()
                }
            } else {
                // Handle unauthenticated state or email not verified
                print("User not authenticated or email not verified.")
            }
        }
    
    }
    
}
#Preview {
    PersonalDataView()
}
