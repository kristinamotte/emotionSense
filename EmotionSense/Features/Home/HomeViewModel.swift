//
//  HomeViewModel.swift
//  EmotionSense
//
//  Created by Kristina Motte on 07/07/2023.
//

import Foundation
import CoreML
import NaturalLanguage

final class HomeViewModel: ObservableObject {
    let menuItems: [MenuItem] = MenuItem.allCases
    
    private let predictionManager: PredictionManager
    
    init(predictionManager: PredictionManager = PredictionManager.shared) {
        self.predictionManager = predictionManager
    }
    
    func predict() {
        let text = "If you were unfairly treated by your employer due to posting or liking something on this platform, we will fund your legal bill."
        
        let results = predictionManager.getPrediction(for: text)
        
        results.forEach { emotion, confidence in
            print("\(emotion) \(confidence)")
        }
    }
}
