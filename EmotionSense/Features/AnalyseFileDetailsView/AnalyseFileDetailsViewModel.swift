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
    
    func analyse() {
        print("analyse started")
        isInProgress = true
        
        Task {
            await withTaskGroup(of: Void.self) { group in
                for item in textList {
                    print("\(item.text) analyse started")
                    group.addTask {
                        let analysis = await self.analyse(for: item.text)
                        
                        await MainActor.run {
                            print("Updating textList for \(item.text)")
                            if let index = self.textList.firstIndex(where: { $0.text == item.text }) {
                                self.textList[index].results = analysis
                            } else {
                                self.textList.append(TextAnalysis(text: item.text, results: analysis))
                            }
                            print("Updated textList: \(self.textList)")
                        }
                    }
                }
                
                // Wait for all tasks to complete
                for await _ in group {}
            }
            
            await MainActor.run {
                print("inProgress updated")
                self.isInProgress = false
            }
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
