//
//  FileAnalyseDetailsView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 29/08/2023.
//

import SwiftUI

struct FileAnalyseDetailsView: View {
    let text: EmotionTextList
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
    }
    
    var Comments: some View {
        ScrollView {
            VStack(spacing: Dimensions.padding24) {
                ForEach(text.texts, id: \.self) { item in
                    VStack(alignment: .leading, spacing: Dimensions.padding16) {
                        Text(item.text)
                            .regular14BlackMultiline
                        EmotionsResultView(results: item.analysedResults.toDictionary, overalReview: "")
                        Divider()
                    }
                    .frame(maxWidth: Dimensions.maxContentSize)
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
