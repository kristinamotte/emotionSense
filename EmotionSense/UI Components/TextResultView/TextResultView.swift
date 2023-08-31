//
//  TextResultView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 31/08/2023.
//

import SwiftUI

struct TextResultView: View {
    let text: String
    let analysedResults: [String: Double]
    let isLoading: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: Dimensions.padding16) {
            Text(text)
                .regular14BlackMultiline
            EmotionsResultView(results: analysedResults, overalReview: "", isLoading: isLoading)
            Divider()
        }
        .frame(maxWidth: Dimensions.maxContentSize)
    }
}

struct TextResultView_Previews: PreviewProvider {
    static var previews: some View {
        TextResultView(text: "", analysedResults: [:], isLoading: false)
    }
}
