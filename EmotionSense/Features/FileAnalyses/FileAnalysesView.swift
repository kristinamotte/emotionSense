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
    @FetchRequest(entity: EmotionTextList.entity(), sortDescriptors: [NSSortDescriptor(key: "dateAdded", ascending: false)])
    var textList: FetchedResults<EmotionTextList>
    
    @FetchRequest(entity: EmotionText.entity(), sortDescriptors: [])
    var texts: FetchedResults<EmotionText>
    
    var body: some View {
        VStack {
            ForEach(textList, id: \.self) { text in
                HStack {
                    Text(text.id)
                    ForEach(text.texts, id: \.self) { item in
                        Text(item.text)
                        ForEach(item.analysedResults, id: \.self) { result in
                            Text(result.emotion)
                            Text("\(result.probability)")
                        }
                    }
                }
            }
            Button {
                let analyse = TextAnalyse(context: viewContext)
                analyse.emotion = EmotionType.anger.rawValue
                analyse.probability = 0.9
                
                let text = EmotionText(context: viewContext)
                text.text = "Test text"
                text.addToAnalysedResults(analyse)
                
                let list = EmotionTextList(context: viewContext)
                list.id = UUID().uuidString
                list.dateAdded = Date.now
                list.addToTexts(text)
                
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
}

struct FileAnalysesView_Previews: PreviewProvider {
    static var previews: some View {
        FileAnalysesView()
    }
}
