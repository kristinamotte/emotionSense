//
//  AnalyseFileDetailsView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 31/08/2023.
//

import SwiftUI

struct AnalyseFileDetailsView: View {
    @StateObject var viewModel: AnalyseFileDetailsViewModel
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            VStack(alignment: .leading, spacing: Dimensions.padding24) {
                Text(viewModel.title)
                    .bold24TextBlack
                VStack(alignment: .trailing, spacing: Dimensions.padding24) {
                    Comments
                }
            }
            Spacer()
        }
        .padding(.leading, Dimensions.padding40)
        .padding(.top, Dimensions.padding56)
        .task {
            await viewModel.analyse()
        }
        .onChange(of: viewModel.textList) { newValue in
            print(newValue)
        }
    }
    
    var Comments: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .trailing, spacing: Dimensions.padding24) {
                VStack(spacing: Dimensions.padding24) {
                    ForEach(viewModel.textList, id: \.self) { item in
                        TextResultView(text: item.text, analysedResults: item.results, isLoading: item.results.isEmpty)
                    }
                }
                if !viewModel.isInProgress {
                    Button {
                        viewModel.save(for: viewContext)
                    } label: {
                        Text("Save")
                            .frame(maxWidth: 170)
                            .modifier(ViewModifiers.defaultButtonHeight)
                    }
                    .buttonStyle(ButtonStyles.defaultNormal)
                    .padding(.bottom, Dimensions.padding32)
                }
            }
        }
    }
}

struct AnalyseFileDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyseFileDetailsView(viewModel: AnalyseFileDetailsViewModel(title: "Test", textList: [TextAnalysis(text: "", results: [:])], shouldNavigateToDetails: .constant(true)))
    }
}
