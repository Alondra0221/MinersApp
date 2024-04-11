//
//  ReportsView.swift
//  FirebaseYoutube
//
//  Created by Alondra García Morales on 01/02/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import MyLibraryHealthKit
import MyLibraryViewModelAltitud

struct ReportsView: View {
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
            
            ScrollView(.vertical){
                
                VStack{
                    VStack{
                        Text("\(login.name) \(login.lastName) ")
                            .font(
                                Font.custom("SF Pro Display", size: 25)
                                    .weight(.bold)
                            )
                            .foregroundStyle(Color("GreenButton"))
                    }.padding(.top, 90)
                    HStack{
                        VStack{
                            Image(systemName: "person").foregroundStyle(.gray)
                                .frame(width: 110, height: 110)
                                .background(
                                    Circle()
                                        .fill(Color.white)
                                )
                        }.padding(.top, -20)
                        HStack(){
                            VStack(alignment:.leading, spacing:12){
                                Text("AGE: ").font(
                                    Font.custom("SF Pro Display", size: 12)
                                        .weight(.bold)
                                )
                                .foregroundStyle(.white)
                                Text("GROUP: ").font(
                                    Font.custom("SF Pro Display", size: 12)
                                        .weight(.bold)
                                )
                                .foregroundStyle(.white)
                                Text("SHIFT: ").font(
                                    Font.custom("SF Pro Display", size: 12)
                                        .weight(.bold)
                                )
                                .foregroundStyle(.white)
                                Text("AREA: ").font(
                                    Font.custom("SF Pro Display", size: 12)
                                        .weight(.bold)
                                )
                                .foregroundStyle(.white)
                                Text("ROLE POSITION:").font(
                                    Font.custom("SF Pro Display", size: 12)
                                        .weight(.bold)
                                )
                                .foregroundStyle(.white)
                            }.padding(.leading, -10)
                            
                            
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
                                
                            }.padding(.leading, 20)
                        }.padding(.leading, 30)
                        
                    }.padding(.top, 15)
                        .padding(.leading, -20)
                    
                }
                VStack{
                    VStack(alignment:.leading){
                        VStack{
                            Text("REPORT DATE:").font(
                                Font.custom("SF Pro Display", size: 16)
                            )
                            .foregroundStyle(.white)
                        }.padding(.leading, 10)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 1)
                            .background(Color(red: 0.74, green: 0.73, blue: 0.73))
                            .padding(10)
                        VStack(alignment:.leading){
                            Text("OXYGEN SATURATION IN THE BLOOD.").font(
                                Font.custom("SF Pro Display", size: 16)
                            )
                            .foregroundStyle(.white)
                            Text("You have had this oxygen saturation").font(
                                Font.custom("SF Pro Display", size: 14)
                            )
                            .foregroundStyle(.white)
                        }.padding(.leading, 10)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 1)
                            .background(Color(red: 0.74, green: 0.73, blue: 0.73))
                            .padding(10)
                        VStack(alignment:.leading){
                            Text("THE HEIGHT YOU ARE AT.").font(
                                Font.custom("SF Pro Display", size: 16)
                            )
                            .foregroundStyle(.white)
                            Text("Your heigh was").font(
                                Font.custom("SF Pro Display", size: 14)
                            )
                            .foregroundStyle(.white)
                        }.padding(.leading, 10)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 1)
                            .background(Color(red: 0.74, green: 0.73, blue: 0.73))
                            .padding(10)
                        VStack(alignment:.leading){
                            Text("HEART RATE.").font(
                                Font.custom("SF Pro Display", size: 16)
                            )
                            .foregroundStyle(.white)
                            Text("Your heart rate around the year was").font(
                                Font.custom("SF Pro Display", size: 14)
                            )
                            .foregroundStyle(.white)
                        }.padding(.leading, 10)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 1)
                            .background(Color(red: 0.74, green: 0.73, blue: 0.73))
                            .padding(10)
                        VStack(alignment:.leading){
                            Text("SUN EXPOSURE TIME.").font(
                                Font.custom("SF Pro Display", size: 16)
                            )
                            .foregroundStyle(.white)
                            Text("Your sun exposure time was").font(
                                Font.custom("SF Pro Display", size: 14)
                            )
                            .foregroundStyle(.white)
                        }.padding(.leading, 10)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 1)
                            .background(Color(red: 0.74, green: 0.73, blue: 0.73))
                            .padding(10)
                        VStack(alignment:.leading){
                            Text("OXYGEN CONSUMED VOLUME.").font(
                                Font.custom("SF Pro Display", size: 16)
                            )
                            .foregroundStyle(.white)
                            Text("Oxygen consumption was").font(
                                Font.custom("SF Pro Display", size: 14)
                            )
                            .foregroundStyle(.white)
                        }.padding(.leading, 10)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 1)
                            .background(Color(red: 0.74, green: 0.73, blue: 0.73))
                            .padding(10)
                        VStack(alignment:.leading){
                            Text("USUAL TEMPERATURE.").font(
                                Font.custom("SF Pro Display", size: 16)
                            )
                            .foregroundStyle(.white)
                            Text("Your temperature was").font(
                                Font.custom("SF Pro Display", size: 14)
                            )
                            .foregroundStyle(.white)
                        }.padding(.leading, 10)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 1)
                            .background(Color(red: 0.74, green: 0.73, blue: 0.73))
                            .padding(10)
                        VStack(alignment:.leading){
                            Text("HISTORY").font(
                                Font.custom("SF Pro Display", size: 16)
                            )
                            .foregroundStyle(.white)
                            Text("Your health in the last four months").font(
                                Font.custom("SF Pro Display", size: 14)
                            )
                            .foregroundStyle(.white)
                        }.padding(.leading, 10)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 1)
                            .background(Color(red: 0.74, green: 0.73, blue: 0.73))
                            .padding(10)
                        VStack(alignment:.leading){
                            Text("RECOMENDATIONS").font(
                                Font.custom("SF Pro Display", size: 16)
                            )
                            .foregroundStyle(.white)
                            Text("Right inigual hernia").font(
                                Font.custom("SF Pro Display", size: 14)
                            )
                            .foregroundStyle(.white)
                        }.padding(.leading, 10)
                        
                        
                        VStack(alignment:.leading){
                            Button(action: {
                                print("back")
                            }){
                                Text("BACK")
                                    .modifier(CustomTextStyle())
                            }.modifier(CustomButtonStyle())
                        }.padding(.leading, 15)
                            .padding(.top, 65)
                        
                    }
                }.CardViewPersonalData()
                    .padding(.top, 30)
                VStack{}.padding(.top, 50)
            }
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


