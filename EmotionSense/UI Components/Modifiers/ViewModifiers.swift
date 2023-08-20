//
//  ViewModifiers.swift
//  EmotionSense
//
//  Created by Kristina Motte on 20/08/2023.
//

import SwiftUI

final class ViewModifiers {
    static let defaultButtonHeight = DefaultButtonHeightModifier()
    
    struct DefaultButtonHeightModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .frame(height: 44.0)
        }
    }
}
