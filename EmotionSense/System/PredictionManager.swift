//
//  PredictionManager.swift
//  EmotionSense
//
//  Created by Kristina Motte on 06/08/2023.
//

import Foundation
import CoreML
import NaturalLanguage

final class PredictionManager {
    static let shared = PredictionManager()
    
    private let emotionModelBuilder: EmotionModelBuilder
    private var predictors: [EmotionType: NLModel] = [:]
    
    init(emotionModelBuilder: EmotionModelBuilder = EmotionModelBuilder()) {
        self.emotionModelBuilder = emotionModelBuilder
        
        EmotionType.allCases.forEach { type in
            if let model = emotionModelBuilder.getModel(of: type), let predictor = try? NLModel(mlModel: model) {
                predictors[type] = predictor
            }
        }
    }
    
    func getPrediction(for text: String) async -> [String: Double] {
        var results: [String: Double] = [:]
        
        if Int(text) != nil || Double(text) != nil {
            results[EmotionType.unknown.rawValue] = 1.0
            
            return results
        }
        
        predictors.forEach { type, predictor in
            let prediction = predictor.predictedLabel(for: text) ?? ""
            let predictionSet = predictor.predictedLabelHypotheses(for: text, maximumCount: 1)
            let confidence = predictionSet[prediction] ?? 0.0
            
            if prediction == "1", confidence > 0.7 {
                results[type.rawValue] = confidence
            }
        }
        
        if results.isEmpty {
            results[EmotionType.unknown.rawValue] = 1.0
        }
        
        return results
    }
}
