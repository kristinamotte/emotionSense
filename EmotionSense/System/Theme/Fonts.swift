//
//  Fonts.swift
//  EmotionSense
//
//  Created by Kristina Motte on 19/08/2023.
//

import SwiftUI

struct Fonts {
    private init() {}
    
    enum Raleway: String {
        case bold = "Raleway-Bold"
        case light = "Raleway-Light"
        case medium = "Raleway-Medium"
        case regular = "Raleway-Regular"
        case semiBold = "Raleway-SemiBold"
    }
}

// MARK: - SemiBold
extension Text {
    var semiBold14DarkGrey: Text {
        self
            .font(.custom(Fonts.Raleway.semiBold.rawValue, size: 14))
            .foregroundColor(Color(Colors.darkGrey))
    }
    
    var semiBold14Blue: Text {
        self
            .font(.custom(Fonts.Raleway.semiBold.rawValue, size: 14))
            .foregroundColor(Color(Colors.blue))
    }
    
    func semiBold14(with customColor: Color) -> Text {
        self
            .font(.custom(Fonts.Raleway.semiBold.rawValue, size: 14))
            .foregroundColor(customColor)
    }
}

// MARK: - Bold
extension Text {
    var bold24TextBlack: Text {
        self
            .font(.custom(Fonts.Raleway.bold.rawValue, size: 24))
            .foregroundColor(Color(Colors.textBlack))
    }
    
    var bold14TextBlack: Text {
        self
            .font(.custom(Fonts.Raleway.bold.rawValue, size: 14))
            .foregroundColor(Color(Colors.textBlack))
    }
}

// MARK: - Regular
extension Text {
    var regular14DarkGrey: Text {
        self
            .font(.custom(Fonts.Raleway.regular.rawValue, size: 14))
            .foregroundColor(Color(Colors.darkGrey))
    }
    
    var regular14DarkBlack: Text {
        self
            .font(.custom(Fonts.Raleway.regular.rawValue, size: 14))
            .foregroundColor(Color(Colors.textBlack))
    }
    
    var regular14DarkGreyMultiline: some View {
        self
            .regular14DarkGrey
            .multilineTextAlignment(.leading)
    }
}

// MARK: - Light
extension Text {
    var light14Black: Text {
        self
            .font(.custom(Fonts.Raleway.light.rawValue, size: 14))
            .foregroundColor(Color(Colors.textBlack))
    }
}
