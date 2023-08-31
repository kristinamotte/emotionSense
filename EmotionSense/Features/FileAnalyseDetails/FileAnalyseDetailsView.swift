//
//  FileAnalyseDetailsView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 29/08/2023.
//

import SwiftUI

struct FileAnalyseDetailsView: View {
    let text: EmotionTextList
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            VStack(alignment: .leading, spacing: Dimensions.padding16) {
                ReturnBackView {
                    presentationMode.wrappedValue.dismiss()
                }
                VStack(alignment: .leading, spacing: Dimensions.padding24) {
                    Text(text.title)
                        .bold24TextBlack
                    Comments
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.leading, Dimensions.padding40)
        .padding(.top, Dimensions.padding56)
        .navigationBarBackButtonHidden(true)
    }
    
    var Comments: some View {
        ScrollView {
            VStack(spacing: Dimensions.padding24) {
                ForEach(text.texts, id: \.self) { item in
                    TextResultView(text: item.text, analysedResults: item.analysedResults.toDictionary, isLoading: false)
                }
                Button {
                    text.remove(for: viewContext) { _ in
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Remove data")
                }
            }
        }
    }
}

struct FileAnalyseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FileAnalyseDetailsView(text: EmotionTextList())
    }
}
