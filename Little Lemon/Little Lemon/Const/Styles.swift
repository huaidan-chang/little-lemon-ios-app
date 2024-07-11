//
//  Styles.swift
//  Little_Lemon_Test
//
//  Created by dana chang on 7/10/24.
//

import SwiftUI

extension Color {
    static let primary1 = Color(#colorLiteral(red: 0.2862745225, green: 0.3686274588, blue: 0.3411764801, alpha: 1))
    static let primary2 = Color(#colorLiteral(red: 0.9568627477, green: 0.8078432088, blue: 0.07843137532, alpha: 1))
    static let secondary1 = Color(#colorLiteral(red: 0.989240706, green: 0.5802358389, blue: 0.4141188264, alpha: 1))
    static let secondary2 = Color(#colorLiteral(red: 1, green: 0.8488721251, blue: 0.7164030075, alpha: 1))
    static let secondary3 = Color(#colorLiteral(red: 0.9276351333, green: 0.9375831485, blue: 0.9331009984, alpha: 1))
    static let secondary4 = Color(#colorLiteral(red: 0.1999999881, green: 0.1999999881, blue: 0.1999999881, alpha: 1))
}

extension Font {
    static func MarkaziTitle() -> Font {
        return Font.custom("MarkaziText-Medium", size: 64)
    }
    
    static func MarkaziSubTitle() -> Font {
        return Font.custom("MarkaziText-Regular", size: 40)
    }
    
    static func KarlaLeadText() -> Font {
        return Font.custom("Karla-Medium", size: 18)
    }
    
    static func KarlaSectionTitle() -> Font {
        return Font.custom("Karla-ExtraBold", size: 20)
    }
    
    static func KarlaSectionCategories() -> Font {
        return Font.custom("Karla-ExtraBold", size: 16)
    }
    
    static func KarlaCardTitle() -> Font {
        return Font.custom("Karla-Bold", size: 18)
    }
    
    static func KarlaParagraphText() -> Font {
        return Font.custom("Karla-Regular", size: 16)
    }
    
    static func KarlaHighlightText() -> Font {
        return Font.custom("Karla-Medium", size: 16)
    }
}

struct LogOutButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.KarlaSectionCategories())
            .frame(maxWidth: .infinity)
            .foregroundColor(configuration.isPressed ? .white : .black)
            .padding(10)
            .background(configuration.isPressed ? Color.primary1 : Color.primary2)
            .cornerRadius(8)
            .padding(.horizontal)
    }
}


struct ButtonStylePrimary: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.KarlaSectionCategories())
            .foregroundColor(configuration.isPressed ? Color.primary1 : .white)
            .padding(13)
            .background(configuration.isPressed ? .white : Color.primary1)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primary1, lineWidth: 1)
            )
            .padding(.horizontal)
    }
}

struct ButtonStyleWhite: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.KarlaSectionCategories())
            .foregroundColor(configuration.isPressed ? .white : Color.primary1)
            .padding(13)
            .background(configuration.isPressed ? Color.primary1 : .white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primary1, lineWidth: 1)
            )
            .padding(.horizontal)
    }
}
