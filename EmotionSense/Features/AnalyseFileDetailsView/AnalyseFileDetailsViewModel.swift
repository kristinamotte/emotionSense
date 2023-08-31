//
//  AnalyseFileDetailsViewModel.swift
//  EmotionSense
//
//  Created by Kristina Motte on 31/08/2023.
//

import Foundation
import CoreData

final class AnalyseFileDetailsViewModel: ObservableObject {
    let title: String
    let texts: [String]
    
    // MARK: - Published
    @Published var textList: [String: [String: Double]] = [:]
    @Published var isInProgress: Bool = true
    
    // MARK: - Dependencies
    private let predictionManager: PredictionManager
    
    init(title: String, texts: [String], predictionManager: PredictionManager = .shared) {
        self.title = title
        self.texts = texts
        self.predictionManager = predictionManager
    }
    
    func setTextList() {
        texts.forEach { text in
            textList[text] = [:]
        }
    }
    
    func analyse() {
        texts.forEach { text in
            Task {
                let analyse = await self.analyse(for: text)

                await MainActor.run {
                    self.textList[text] = analyse
                }
            }
        }

        isInProgress = false
    }
    
    func save(for viewContext: NSManagedObjectContext) {
        let list = EmotionTextList(context: viewContext)
        list.id = UUID().uuidString
        list.dateAdded = Date.now
        list.title = title
        
        textList.forEach { (key, values) in
            let text = EmotionText(context: viewContext)
            text.text = key
            
            values.forEach { (emotion, probability) in
                let analyse = TextAnalyse(context: viewContext)
                analyse.emotion = emotion
                analyse.probability = probability
                text.addToAnalysedResults(analyse)
            }
            
            list.addToTexts(text)
        }
        
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            print(error)
        }
    }
    
    private func analyse(for text: String) async -> [String: Double] {
        let cleanedText = text.filter { !$0.isPunctuation && !$0.isSymbol }
        let results = await predictionManager.getPrediction(for: cleanedText)
        
        return results
    }
}
