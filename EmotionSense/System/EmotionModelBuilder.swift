//
//  EmotionModelBuilder.swift
//  EmotionSense
//
//  Created by Kristina Motte on 06/08/2023.
//

import Foundation
import CoreML
import NaturalLanguage

final class EmotionModelBuilder {
    private var models: [EmotionType: MLModel] = [:]
    
    init() {
        getAllModels()
    }
    
    func getModel(of type: EmotionType) -> MLModel? {
        return models[type]
    }
    
    // MARK: - Helpers
    private func getAllModels() {
        EmotionType.allCases.forEach { type in
            if let model = getModel(for: type) {
                models[type] = model
            }
        }
    }
    
    private func getModel(for emotionType: EmotionType) -> MLModel? {
        var model: MLModel?
        
        switch emotionType {
        case .disgust:
            model = try? disgust(configuration: MLModelConfiguration()).model
        case .sadness:
            model = try? sadness(configuration: MLModelConfiguration()).model
        case .relief:
            model = try? relief(configuration: MLModelConfiguration()).model
        case .caring:
            model = try? caring(configuration: MLModelConfiguration()).model
        case .grief:
            model = try? grief(configuration: MLModelConfiguration()).model
        case .optimism:
            model = try? optimism(configuration: MLModelConfiguration()).model
        case .remorse:
            model = try? remorse(configuration: MLModelConfiguration()).model
        case .curiosity:
            model = try? curiosity(configuration: MLModelConfiguration()).model
        case .approval:
            model = try? approval(configuration: MLModelConfiguration()).model
        case .love:
            model = try? love(configuration: MLModelConfiguration()).model
        case .annoyance:
            model = try? annoyance(configuration: MLModelConfiguration()).model
        case .neutral:
            model = try? neutral(configuration: MLModelConfiguration()).model
        case .excitement:
            model = try? excitement(configuration: MLModelConfiguration()).model
        case .fear:
            model = try? fear(configuration: MLModelConfiguration()).model
        case .joy:
            model = try? joy(configuration: MLModelConfiguration()).model
        case .anger:
            model = try? anger(configuration: MLModelConfiguration()).model
        case .realization:
            model = try? realization(configuration: MLModelConfiguration()).model
        case .pride:
            model = try? pride(configuration: MLModelConfiguration()).model
        case .surprise:
            model = try? surprise(configuration: MLModelConfiguration()).model
        case .gratitude:
            model = try? gratitude(configuration: MLModelConfiguration()).model
        case .embarrassment:
            model = try? embarrassment(configuration: MLModelConfiguration()).model
        case .disapproval:
            model = try? disapproval(configuration: MLModelConfiguration()).model
        case .nervousness:
            model = try? nervousness(configuration: MLModelConfiguration()).model
        case .amusement:
            model = try? amusement(configuration: MLModelConfiguration()).model
        case .confusion:
            model = try? confusion(configuration: MLModelConfiguration()).model
        case .disappointment:
            model = try? disappointment(configuration: MLModelConfiguration()).model
        case .desire:
            model = try? desire(configuration: MLModelConfiguration()).model
        case .admiration:
            model = try? admiration(configuration: MLModelConfiguration()).model
        case .unknown:
            break
        }
        
        return model
    }
}
