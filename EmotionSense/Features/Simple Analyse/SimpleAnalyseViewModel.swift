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
    
    // MARK: - Dependencies
    private let predictionManager: PredictionManager
    
    init(predictionManager: PredictionManager = .shared) {
        self.predictionManager = predictionManager
    }
    
    func analyse(for text: String) {
        isAnalysing = true
        
        Task {
            let results = await predictionManager.getPrediction(for: text)
            
            await MainActor.run {
                self.analyseResults = results
                self.isAnalysing = false
            }
        }
    }
}
