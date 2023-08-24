//
//  EmotionsResultView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 21/08/2023.
//

import SwiftUI

struct EmotionsResultView: View {
    let results: [String: Double]
    let overalReview: String
    
    // MARK: - Helpers
    private let itemsPerRow = 3
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            EmojiSection
            Group {
                HStack(alignment: .center, spacing: .zero) {
                    Text("Overall analysis: ")
                        .bold14TextBlack
                    Text(overalReview)
                        .regular14DarkBlack
                }
                .padding(.leading, 24)
                Spacer()
            }
        }
    }
    
    var EmojiSection: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(results.sorted { $0.1 > $1.1 }, id: \.key) { item in
                EmotionProbabilityView(emotionType: EmotionType(rawValue: item.key) ?? .unknown, probability: item.value)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 4)
            }
        }
        .padding(.all, 24)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(Colors.yellowBg)))
    }
    
    private let columns = [
        GridItem(.flexible(minimum: 150, maximum: 300)), GridItem(.flexible(minimum: 150, maximum: 300)), GridItem(.flexible(minimum: 150, maximum: 300))
    ]
    
    private var numberOfRows: Int {
        (results.count + itemsPerRow - 1) / itemsPerRow
    }
    
    private var orderedResults: [(key: String, value: Double)] {
        let sortedResults = results.sorted(by: { $0.1 < $1.1 })
        
        return Array(sortedResults)
    }
}

struct EmotionsResultView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionsResultView(results: [
            EmotionType.disgust.rawValue: 1.0,
            EmotionType.admiration.rawValue: 0.2,
            EmotionType.love.rawValue: 0.9,
            EmotionType.sadness.rawValue: 0.4,
            EmotionType.joy.rawValue: 0.4
        ], overalReview: "")
    }
}