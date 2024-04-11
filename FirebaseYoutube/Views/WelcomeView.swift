//
//  WelcomeView.swift
//  FirebaseYoutube
//
//  Created by Alondra García Morales on 31/01/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import MyLibraryHealthKit
import MyLibraryViewModelAltitud

struct WelcomeView: View {

    @StateObject var login = FirebaseViewModel()
    @StateObject var viewModel1 = viewModelHealthKit()
    @StateObject var locationViewModel = viewModelAltitud()
    @EnvironmentObject var loginShow: FirebaseViewModel
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Image("GreenBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                ScrollView(.vertical){
                    VStack{
                        HStack(spacing: 15){
                            
                            Image(systemName: "person").foregroundStyle(.gray)
                                .frame(width: 95, height: 95)
                                .background(
                                    Circle()
                                        .fill(Color.white)
                                )
                                .padding(.top, 55)
                                .padding(.leading, -80)
                            VStack(alignment: .leading){
                                
                                Text("WELCOME")
                                    .font(
                                        Font.custom("SF Pro Display", size: 18)
                                            .weight(.bold)
                                    )
                                    .kerning(0.9)
                                    .foregroundColor(Color("GreenButton"))
                                
                                Text("\(login.name)\n\(login.lastName) ")
                                    .font(
                                        Font.custom("SF Pro Display", size: 25)
                                            .weight(.bold)
                                    )
                                    .foregroundColor(.white)
                            }.padding(.top, 90).padding(.bottom, 30)
                        }
                        
                        
                        
                        VStack(spacing: 20){
                            VStack(alignment: .leading, spacing: 30){
                                HStack{
                                    Image(systemName: "person.fill").frame(width: 25.21094, height: 30.0918).foregroundStyle(Color.white)
                                    Text("Personal data")
                                        .font(
                                            Font.custom("SF Pro Display", size: 16)
                                                .weight(.bold)
                                        )
                                        .kerning(2.08)
                                        .foregroundStyle(.white)
                                    
                                    NavigationLink {
                                        PersonalDataView()
                                            
                                    } label: {
                                        Image(systemName: "chevron.right").frame(width: 25.21094, height: 30.0918).foregroundStyle(Color.white).padding(.leading,118)
                                        
                                    }
                                }
                                
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 310, height: 1)
                                    .background(Color(red: 0.74, green: 0.73, blue: 0.73))
                                
                                HStack{
                                    Image(systemName: "list.bullet.rectangle.portrait").frame(width: 25.21094, height: 30.0918)
                                        .foregroundStyle(Color.white)
                                    Text("Reports")
                                        .font(
                                            Font.custom("SF Pro Display", size: 16)
                                                .weight(.bold)
                                        )
                                        .kerning(2.08)
                                        .foregroundStyle(.white)
                                    
                                    NavigationLink {
                                       ReportsView()
                                    } label: {
                                        Image(systemName: "chevron.right").frame(width: 25.21094, height: 30.0918).foregroundStyle(Color.white).padding(.leading,172)
                                        
                                    }
                                }
                            }.CardView()
                            
                            Text("HEALTH")
                                .font(
                                    Font.custom("SF Pro Display", size: 20)
                                        .weight(.bold)
                                )
                                .kerning(1.87)
                                .foregroundColor(.white)
                                .padding(.leading, -180)
                            VStack(){
                                HStack(spacing: 25){
                                    VStack(spacing:25){
                                        Text("HEART RATE")
                                            .padding(.trailing, 50)
                                            .padding(.top, -10)
                                            .font(
                                                Font.custom("SF Pro Display", size: 12)
                                                    .weight(.bold)
                                            )
                                            .kerning(1.92)
                                            .foregroundColor(.white)
                                        
                                        Image(systemName: "heart")
                                            .font(.system(size: 65))
                                            .foregroundStyle(Color.white)
                                        Text("Your heart rate is \(viewModel1.heartRate) BPM")
                                            .font(
                                                Font.custom("SF Pro Display", size: 14)
                                                    .weight(.light)
                                            )
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                            .frame(width: 132, alignment: .top)
                                    }.SmallCardView()
                                    
                                    VStack(spacing:25){
                                        Text("TEMPERATURE")
                                            .padding(.trailing, 25)
                                            .font(
                                                Font.custom("SF Pro Display", size: 12)
                                                    .weight(.bold)
                                            )
                                            .kerning(1.92)
                                            .foregroundColor(.white)
                                        Image("custom.medical.thermometer")
                                            .font(.system(size: 65))
                                            .foregroundStyle(Color("GreenButton"))
                                        Text("Your temperature is \n\(viewModel1.bodyTemperature) °Fahrenhei")
                                            .font(
                                                Font.custom("SF Pro Display", size: 14)
                                                    .weight(.light)
                                            )
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                            .frame(width: 132, alignment: .top)
                                    }.SmallCardView()
                                }
                            }
                            VStack(){
                                HStack(spacing: 25){
                                    VStack(spacing:25){
                                        Text("OXYGEN SATURATION")
                                            .padding(.trailing, 45)
                                            .font(
                                                Font.custom("SF Pro Display", size: 12)
                                                    .weight(.bold)
                                            )
                                            .kerning(1.92)
                                            .foregroundColor(.white)
                                        Image("custom.lungs")
                                            .font(.system(size: 65))
                                            .foregroundStyle(Color("GreenButton"))
                                        Text("You're oxygen saturation is \(viewModel1.oxygenSaturation) %")
                                            .font(
                                                Font.custom("SF Pro Display", size: 14)
                                                    .weight(.light)
                                            )
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                            .frame(width: 132, alignment: .top)
                                    }.SmallCardView()
                                    
                                    VStack(spacing:25){
                                        Text("SUN EXPOSURE")
                                            .padding(.trailing, 15)
                                            .padding(.top, -18)
                                            .font(
                                                Font.custom("SF Pro Display", size: 12)
                                                    .weight(.bold)
                                            )
                                            .kerning(1.92)
                                            .foregroundColor(.white)
                                        Image("custom.sun.max")
                                            .font(.system(size: 65))
                                            .foregroundStyle(Color("GreenButton"))
                                        Text("Your UV index \(viewModel1.uvExposure)")
                                            .font(
                                                Font.custom("SF Pro Display", size: 14)
                                                    .weight(.light)
                                            )
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                            .frame(width: 132, alignment: .top)
                                    }.SmallCardView()
                                }
                            }
                            VStack(){
                                HStack(spacing: 25){
                                    VStack(spacing:25){
                                        Text("VO2 MAX")
                                            .padding(.trailing, 65)
                                            .font(
                                                Font.custom("SF Pro Display", size: 12)
                                                    .weight(.bold)
                                            )
                                            .kerning(1.92)
                                            .foregroundColor(.white)
                                        Image("custom.staroflife")
                                            .font(.system(size: 65))
                                            .foregroundStyle(Color("GreenButton"))
                                        Text("Volume of oxygen consumed is \(viewModel1.vo2Max)")
                                            .font(
                                                Font.custom("SF Pro Display", size: 14)
                                                    .weight(.light)
                                            )
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                            .frame(width: 132, alignment: .top)
                                    }.SmallCardView()
                                    
                                    VStack(spacing:25){
                                        Text("ALTITUDE")
                                            .padding(.trailing, 64)
                                            .font(
                                                Font.custom("SF Pro Display", size: 12)
                                                    .weight(.bold)
                                            )
                                            .kerning(1.92)
                                            .foregroundColor(.white)
                                        Image("custom.mappin")
                                            .font(.system(size: 65))
                                            .foregroundStyle(Color("GreenButton"))
                                        Text("Your altitude is \(locationViewModel.altitude)")
                                            .font(
                                                Font.custom("SF Pro Display", size: 14)
                                                    .weight(.light)
                                            )
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(.white)
                                            .frame(width: 132, alignment: .top)
                                    }.SmallCardView()
                                }
                            }
                            VStack{
                                
                            }
                        }
                    }
                }
            }
        }.tint(.white)
            .onAppear {
            if let userId = Auth.auth().currentUser?.uid {
                Task {
                    await login.getData(uid: userId)
                    viewModel1.requestAccessToHealthData()
                }
            } else {
                // Handle unauthenticated state or email not verified
                print("User not authenticated or email not verified.")
            }
            
        }
    }
}

