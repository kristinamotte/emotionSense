//
//  FileAnalysesView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 24/08/2023.
//

import SwiftUI
import CoreData

struct FileAnalysesView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        Button {
//            let texts = EmotionText(context: viewContext)
//            texts.text = "Test"
            
            let analyse = TextAnalyse(context: viewContext)
            analyse.emotion = EmotionType.admiration.rawValue
            analyse.probability = 0.5
//            texts.addToAnalyse(analyse)
//
//            let list = EmotionList(context: viewContext)
//            list.id = "12"
//            list.dateAdded = Date.now
//            list.addToTexts(texts)
            
            do {
                try viewContext.save()
            } catch {
                let error = error as NSError
                print(error)
            }
        } label: {
            Text("Try")
        }
    }
}

struct FileAnalysesView_Previews: PreviewProvider {
    static var previews: some View {
        FileAnalysesView()
    }
}
