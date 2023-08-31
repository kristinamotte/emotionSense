//
//  AnalyseFileDetailsViewModel.swift
//  EmotionSense
//
//  Created by Kristina Motte on 31/08/2023.
//

import SwiftUI
import CoreData

final class AnalyseFileDetailsViewModel: ObservableObject {
    let title: String
    
    // MARK: - Published
    @Published var textList: [TextAnalysis]
    @Published var isInProgress: Bool = true
    @Binding var shouldNavigateToDetails: Bool
    
    // MARK: - Dependencies
    private let predictionManager: PredictionManager
    
    init(title: String, textList: [TextAnalysis], shouldNavigateToDetails: Binding<Bool>, predictionManager: PredictionManager = .shared) {
        self.title = title
        self.textList = textList
        self._shouldNavigateToDetails = shouldNavigateToDetails
        self.predictionManager = predictionManager
    }
    
    @MainActor
    func analyse() async {
        isInProgress = true
        
        await withTaskGroup(of: Void.self) { group in
            for item in textList {
                group.addTask {
                    let analysis = await self.analyse(for: item.text)
                    
                    // Since the enclosing function is already running on the main actor,
                    // there's no need to switch to it again.
                    await MainActor.run {
                        if let index = self.textList.firstIndex(where: { $0.text == item.text }) {
                            self.textList[index] = TextAnalysis(text: item.text, results: analysis)
                        } else {
                            self.textList.append(TextAnalysis(text: item.text, results: analysis))
                        }
                    }
                }
            }
            
            // Wait for all tasks to complete
            for await _ in group {}
        }
        
        await MainActor.run {
            self.isInProgress = false
        }
    }

    func save(for viewContext: NSManagedObjectContext) {
        let list = EmotionTextList(context: viewContext)
        list.id = UUID().uuidString
        list.dateAdded = Date.now
        list.title = title
        
        textList.forEach { item in
            let text = EmotionText(context: viewContext)
            text.text = item.text
            
            item.results.forEach { (emotion, probability) in
                let analyse = TextAnalyse(context: viewContext)
                analyse.emotion = emotion
                analyse.probability = probability
                text.addToAnalysedResults(analyse)
            }
            
            list.addToTexts(text)
        }
        
        do {
            try viewContext.save()
            self.shouldNavigateToDetails = false
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
