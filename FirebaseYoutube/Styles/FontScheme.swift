//
//  FontScheme.swift
//  FirebaseYoutube
//
//  Created by Alondra García Morales on 30/01/24.
//

import Foundation
import SwiftUI

class FontScheme: NSObject {
    static func kBebasNeueRegular(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kBebasNeueRegular, size: size)
    }

    static func kSFProDisplayRegular(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kSFProDisplayRegular, size: size)
    }

    static func kSFProDisplayMedium(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kSFProDisplayMedium, size: size)
    }

    static func kSFProDisplayBold(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kSFProDisplayBold, size: size)
    }

    static func kSFProDisplayLight(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kSFProDisplayLight, size: size)
    }

    static func kSFProDisplaySemibold(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kSFProDisplaySemibold, size: size)
    }

    static func fontFromConstant(fontName: String, size: CGFloat) -> Font {
        var result = Font.system(size: size)

        switch fontName {
        case "kBebasNeueRegular":
            result = self.kBebasNeueRegular(size: size)
        case "kSFProDisplayRegular":
            result = self.kSFProDisplayRegular(size: size)
        case "kSFProDisplayMedium":
            result = self.kSFProDisplayMedium(size: size)
        case "kSFProDisplayBold":
            result = self.kSFProDisplayBold(size: size)
        case "kSFProDisplayLight":
            result = self.kSFProDisplayLight(size: size)
        case "kSFProDisplaySemibold":
            result = self.kSFProDisplaySemibold(size: size)
        default:
            result = self.kBebasNeueRegular(size: size)
        }
        return result
    }

    enum FontConstant {
        /**
         * Please Add this fonts Manually
         */
        static let kBebasNeueRegular: String = "BebasNeue-Regular"
        /**
         * Please Add this fonts Manually
         */
        static let kSFProDisplayRegular: String = "SFProDisplay-Regular"
        /**
         * Please Add this fonts Manually
         */
        static let kSFProDisplayMedium: String = "SFProDisplay-Medium"
        /**
         * Please Add this fonts Manually
         */
        static let kSFProDisplayBold: String = "SFProDisplay-Bold"
        /**
         * Please Add this fonts Manually
         */
        static let kSFProDisplayLight: String = "SFProDisplay-Light"
        /**
         * Please Add this fonts Manually
         */
        static let kSFProDisplaySemibold: String = "SFProDisplay-Semibold"
    }
}
