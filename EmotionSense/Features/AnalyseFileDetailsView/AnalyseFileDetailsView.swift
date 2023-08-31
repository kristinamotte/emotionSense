//
//  AnalyseFileDetailsView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 31/08/2023.
//

import SwiftUI

struct AnalyseFileDetailsView: View {
    @ObservedObject var viewModel: AnalyseFileDetailsViewModel
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            VStack(alignment: .leading, spacing: Dimensions.padding16) {
                ReturnBackView {
                    presentationMode.wrappedValue.dismiss()
                }
                VStack(alignment: .leading, spacing: Dimensions.padding24) {
                    Text(viewModel.title)
                        .bold24TextBlack
                    VStack(alignment: .trailing, spacing: Dimensions.padding24) {
                        Comments
                        Button {
                            viewModel.save(for: viewContext)
                        } label: {
                            Text("Save")
                                .frame(maxWidth: 170)
                                .modifier(ViewModifiers.defaultButtonHeight)
                        }
                        .buttonStyle(ButtonStyles.defaultNormal)
                        .disabled(viewModel.isInProgress)
                    }
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.leading, Dimensions.padding40)
        .padding(.top, Dimensions.padding56)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.setTextList()
            viewModel.analyse()
        }
    }
    
    var Comments: some View {
        ScrollView {
            VStack(spacing: Dimensions.padding24) {
                ForEach(viewModel.texts, id: \.self) { item in
                    TextResultView(text: item, analysedResults: viewModel.textList[item] ?? [:], isLoading:  viewModel.textList[item] == nil)
                }
            }
        }
    }
}

struct AnalyseFileDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyseFileDetailsView(viewModel: AnalyseFileDetailsViewModel(title: "Test", texts: ["Test"]))
    }
}
