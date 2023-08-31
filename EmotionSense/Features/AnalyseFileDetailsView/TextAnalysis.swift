//
//  TextAnalysis.swift
//  EmotionSense
//
//  Created by Kristina Motte on 31/08/2023.
//

import Foundation

struct TextAnalysis: Hashable, Equatable {
    let text: String
    let results: [String: Double]
    
    static func == (lhs: TextAnalysis, rhs: TextAnalysis) -> Bool {
        lhs.text == rhs.text
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
}
