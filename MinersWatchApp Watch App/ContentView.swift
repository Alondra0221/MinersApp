//
//  ContentView.swift
//  MinersWatchApp Watch App
//
//  Created by Alondra García Morales on 13/02/24.
//

import SwiftUI
import MyLibraryHealthKit
import MyLibraryViewModelAltitud

struct ContentView: View {
    @StateObject var viewModel1 = viewModelHealthKit()
    @StateObject var locationViewModel = viewModelAltitud()
    
    var body: some View {
        ZStack{
            Image("GreenBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            TabView{
                VStack(alignment: .center, spacing:20){
                    Text("HEART RATE")
                        .font(
                            Font.custom("SF Pro Display", size: 16)
                                .weight(.bold)
                        )
                        .kerning(1.92)
                        .foregroundColor(.white)
                    
                    Image(systemName: "heart")
                        .font(.system(size: 50))
                        .foregroundStyle(Color.white)
                    Text("Your heart rate is \(viewModel1.heartRate) BPM")
                        .font(
                            Font.custom("SF Pro Display", size: 12)
                                .weight(.light)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(width: 132, alignment: .top)
                }.padding(.top, -20)
                VStack(alignment: .center, spacing:20){
                    Text("TEMPERATURE")
                        .font(
                            Font.custom("SF Pro Display", size: 16)
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
                }.padding(.top, -20)
                VStack(alignment: .center, spacing:20){
                    Text("OXYGEN SATURATION")
                        .font(
                            Font.custom("SF Pro Display", size: 16)
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
                }.padding(.top, -20)
                VStack(alignment: .center, spacing:20){
                    Text("SUN EXPOSURE")
                        .font(
                            Font.custom("SF Pro Display", size: 16)
                                .weight(.bold)
                        )
                        .kerning(1.92)
                        .foregroundColor(.white)
                    Image("custom.sun.max")
                        .font(.system(size: 35))
                        .foregroundStyle(Color("GreenButton"))
                    Text("Your UV index \(viewModel1.uvExposure)")
                        .font(
                            Font.custom("SF Pro Display", size: 11)
                                .weight(.light)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                }.padding(.top, -20)
                VStack(alignment: .center, spacing:20){
                    Text("VO2 MAX")
                        .font(
                            Font.custom("SF Pro Display", size: 16)
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
                }.padding(.top, -20)
                VStack(alignment: .center, spacing:20){
                    Text("ALTITUDE")
                        .font(
                            Font.custom("SF Pro Display", size: 16)
                                .weight(.bold)
                        )
                        .kerning(1.92)
                        .foregroundColor(.white)
                    Image("custom.mappin")
                        .font(.system(size: 65))
                        .foregroundStyle(Color("GreenButton"))
                    Text("Your altitude is \(locationViewModel.altitude)")
                        .font(
                            Font.custom("SF Pro Display", size: 12)
                                .weight(.light)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(width: 132, alignment: .top)
                }.padding(.top, -20)
                .tabViewStyle(.carousel)
            }
        }.onAppear{
            viewModel1.requestAccessToHealthData()
        }
    }
}

