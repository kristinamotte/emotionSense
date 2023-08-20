//
//  ButtonStyles.swift
//  EmotionSense
//
//  Created by Kristina Motte on 20/08/2023.
//

import SwiftUI

final class ButtonStyles {
    static let defaultNormal = DefaultNormal()
    
    struct DefaultNormal: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .buttonStyle(.plain)
                .font(.custom(Fonts.Raleway.bold.rawValue, size: 14.0))
                .foregroundColor(Color.white)
                .background(RoundedRectangle(cornerRadius: .infinity)).foregroundColor(configuration.isPressed ? Color(Colors.pressedBlue) : Color(Colors.blue))
        }
    }
}
