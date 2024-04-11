//
//  stylesComponents.swift
//  FirebaseYoutube
//
//  Created by Alondra García Morales on 29/01/24.
//
import Foundation
import SwiftUI

struct CustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 87, height: 29)
            .font(Font.custom("SF Pro Display", size: 24).weight(.bold))
            .foregroundColor(.black)
            .lineSpacing(29)
            .kerning(2)
            .multilineTextAlignment(.leading)
    }
}
struct CustomButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 299, height: 52)
            .foregroundColor(.white)
            .font(.system(size: 18).weight(.bold)) 
            .background(Color("GreenButton"))
            .cornerRadius(7)
            .shadow(color: Color("GreenButton").opacity(0.8), radius: 26, x: -1, y: 2)
            
    }
}

struct CustomTexLogouttStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 70, height: 40)
            .font(Font.custom("SF Pro Display", size: 14).weight(.bold))
            .foregroundColor(.black)
            .lineSpacing(15)
            .kerning(1)
            .multilineTextAlignment(.leading)
    }
}
struct CustomButtonLogutStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 200, height: 35)
            .foregroundColor(.white)
            .font(.system(size: 10).weight(.bold))
            .background(Color("GreenButton"))
            .cornerRadius(7)
            .shadow(color: Color("GreenButton").opacity(0.8), radius: 26, x: -1, y: 2)
            
    }
}

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(width: 297 ,height: 1).padding(.top, 35))
            .foregroundColor(.white)
            .padding(29)
        
    }
}

///Welcome Components

extension View {
    func CardView() -> some View {
        self
            .foregroundColor(.clear)
            .frame(width: 370, height: 204)
            .background(.black.opacity(0.3))
            .cornerRadius(13)
            .shadow(color: Color("GreenButton").opacity(0.15), radius: 10, x: 0, y: 0)
            .overlay(
                RoundedRectangle(cornerRadius: 13)
                    .inset(by: 0.5)
                    .stroke(Color("GreenButton"), lineWidth: 1)
            )
        
    }
}

extension View {
    func CardViewPersonalData() -> some View {
        self
            .foregroundColor(.clear)
            .frame(width: 370, height: 765)
            .background(.black.opacity(0.3))
            .cornerRadius(13)
            .shadow(color: Color("GreenButton").opacity(0.15), radius: 10, x: 0, y: 0)
            .overlay(
                RoundedRectangle(cornerRadius: 13)
                    .inset(by: 0.5)
                    .stroke(Color("GreenButton"), lineWidth: 1)
            )
        
    }
}

extension View {
    func SmallCardView() -> some View {
        self
            .foregroundColor(.clear)
            .frame(width: 170, height: 209)
            .background(.black.opacity(0.3))
        
            .cornerRadius(13)
            .overlay(
                RoundedRectangle(cornerRadius: 13)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.36, green: 0.88, blue: 0.04), lineWidth: 1)
                
            )
        
    }
}
