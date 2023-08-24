//
//  EmotionProbabilityView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 21/08/2023.
//

import SwiftUI

struct EmotionProbabilityView: View {
    let emotionType: EmotionType
    let probability: Double
    
    var body: some View {
        HStack(alignment: .center, spacing: Dimensions.padding8) {
            Text(emotionType.emoji)
                .regular24DarkBlack
            Text(emotionText)
                .regular14DarkBlack
            Spacer()
        }
    }
    
    private var emotionText: String {
        "\(emotionType.rawValue) - \(String(format: "%.1f/1.0", probability))"
    }
}

struct EmotionProbabilityView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionProbabilityView(emotionType: .admiration, probability: 0.9)
    }
}
