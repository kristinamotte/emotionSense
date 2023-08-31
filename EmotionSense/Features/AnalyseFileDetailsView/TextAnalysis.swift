//
//  TextAnalysis.swift
//  EmotionSense
//
//  Created by Kristina Motte on 31/08/2023.
//

import Foundation

final class TextAnalysis: ObservableObject, Hashable, Equatable {
    @Published var text: String
    @Published var results: [String: Double]

    init(text: String, results: [String: Double]) {
        self.text = text
        self.results = results
    }
    
    static func == (lhs: TextAnalysis, rhs: TextAnalysis) -> Bool {
        lhs.text == rhs.text
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
}
