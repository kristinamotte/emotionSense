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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            VStack(alignment: .leading, spacing: Dimensions.padding24) {
                Text(text.title)
                    .bold24TextBlack
                Comments
            }
            Spacer()
        }
        .padding(.leading, Dimensions.padding40)
        .padding(.top, Dimensions.padding56)
    }
    
    var Comments: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .trailing, spacing: Dimensions.padding24) {
                VStack(spacing: Dimensions.padding24) {
                    ForEach(text.texts, id: \.self) { item in
                        TextResultView(text: item.text, analysedResults: item.analysedResults.toDictionary, isLoading: false)
                    }
                }
                Button {
                    text.remove(for: viewContext) { _ in
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    HStack(alignment: .center, spacing: Dimensions.padding16) {
                        Image("ic_remove")
                        Text("Remove data")
                    }
                    .padding(.horizontal, Dimensions.padding16)
                    .modifier(ViewModifiers.defaultButtonHeight)
                }
                .buttonStyle(ButtonStyles.redNormal)
                .padding(.bottom, Dimensions.padding32)
            }
        }
    }
}

struct FileAnalyseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FileAnalyseDetailsView(text: EmotionTextList())
    }
}
