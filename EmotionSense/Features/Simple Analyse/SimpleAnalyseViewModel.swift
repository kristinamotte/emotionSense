//
//  SimpleAnalyseViewModel.swift
//  EmotionSense
//
//  Created by Kristina Motte on 19/08/2023.
//

import SwiftUI

final class SimpleAnalyseViewModel: ObservableObject {
    @Published var isAnalysing: Bool = false
    @Published var numberOfChars: Int = .zero
    @Published var analyseResults: [String: Double] = [:]
    @Published var overallSummary: String = ""
    
    // MARK: - Dependencies
    private let predictionManager: PredictionManager
    
    init(predictionManager: PredictionManager = .shared) {
        self.predictionManager = predictionManager
    }
    
    func analyse(for text: String) {
        isAnalysing = true
        
        Task {
            let cleanedText = text.filter { !$0.isPunctuation && !$0.isSymbol }
            let results = await predictionManager.getPrediction(for: cleanedText)
            
            await MainActor.run {
                self.analyseResults = results
                self.isAnalysing = false
                self.setOverallSummary()
            }
        }
    }
    
    func setOverallSummary() {
        let emotions = EmotionType.allCases
        
        // Find the emotion with the highest probability
        guard let highestEmotion = emotions.max(by: { analyseResults[$0.rawValue, default: 0.0] < analyseResults[$1.rawValue, default: 0.0] }) else {
            overallSummary = "Unable to determine the overview summary."
            return
        }
                
        if highestEmotion == .neutral {
            overallSummary = "The impression is of someone who maintains a neutral stance."
        } else if highestEmotion.isPositiveEmotion {
            overallSummary = "It appears that someone is brimming with optimism."
        } else if highestEmotion == .unknown {
            overallSummary = "Unable to determine the overview summary."
        } else {
            overallSummary = "It seems like someone harbors strong negative emotions."
        }
    }
}
