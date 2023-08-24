//
//  SimpleAnalyseView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 19/08/2023.
//

import SwiftUI

struct SimpleAnalyseView: View {
    @ObservedObject var viewModel: SimpleAnalyseViewModel
    
    // MARK: - Private
    @StateObject private var inputBindingManager = InputBindingManager(limit: 300)
    
    var body: some View {
        HStack(spacing: .zero) {
            VStack(alignment: .leading, spacing: Dimensions.padding24) {
                Description
                InputField
                Results
                Spacer()
            }
            Spacer()
        }
        .padding(.leading, Dimensions.padding40)
        .padding(.top, Dimensions.padding56)
        .onChange(of: inputBindingManager.input) { text in
            viewModel.numberOfChars = text.count
            
            if text.count == .zero {
                viewModel.analyseResults = [:]
            }
        }
    }
    
    var Description: some View {
        VStack(alignment: .leading, spacing: Dimensions.padding16) {
            Text("Analyse simple text")
                .bold24TextBlack
            Text("Here, you can quickly analyze a small text to try out our product. If you don't want to waste time on file creation, this is the perfect option.")
                .regular14DarkGreyMultiline
                .lineSpacing(Dimensions.defaultLineSpacing)
        }
        .frame(maxWidth: Dimensions.maxContentSize)
    }
    
    var InputField: some View {
        VStack(alignment: .leading, spacing: Dimensions.padding12) {
            TextEditor(text: $inputBindingManager.input)
                .font(.custom(Fonts.Raleway.semiBold.rawValue, size: 14))
                .foregroundColor(Color(Colors.textBlack))
                .padding(.all, Dimensions.padding16)
                .border(Color(Colors.borderGrey), width: 2.0)
                .cornerRadius(Dimensions.cornerRadius / 2)
                .frame(minWidth: Dimensions.maxContentSize, maxWidth: Dimensions.maxContentSize, maxHeight: 165)
                .disabled(viewModel.isAnalysing)
                .onChange(of: inputBindingManager.input, perform: editingChanged)
            HStack(alignment: .center, spacing: .zero) {
                CharactersLimit
                Spacer()
                Button {
                    viewModel.analyse(for: inputBindingManager.input)
                } label: {
                    ButtonContent
                        .frame(maxWidth: 170)
                        .modifier(ViewModifiers.defaultButtonHeight)
                }
                .buttonStyle(ButtonStyles.defaultNormal)
                .disabled(viewModel.isAnalysing || viewModel.numberOfChars == .zero)
            }
        }
        .frame(maxWidth: Dimensions.maxContentSize)
    }
    
    @ViewBuilder var ButtonContent: some View {
        if viewModel.isAnalysing {
            ProgressView()
                .colorInvert()
                .brightness(1)
                .scaleEffect(x: 0.5, y: 0.5, anchor: .center)
        } else {
            Text("Analyse")
        }
    }
    
    var CharactersLimit: some View {
        HStack(alignment: .center, spacing: .zero) {
            Group {
                Text("\(viewModel.numberOfChars)")
                Text("/300 chars")
            }
        }
    }
    
    @ViewBuilder var Results: some View {
        if !viewModel.analyseResults.isEmpty {
            EmotionsResultView(results: viewModel.analyseResults, overalReview: viewModel.overallSummary)
                .frame(maxWidth: Dimensions.maxContentSize)
        }
    }
    
    // MARK: - Private
    private func editingChanged(_ value: String) {
        inputBindingManager.input = String(value.prefix(inputBindingManager.characterLimit))
        viewModel.analyseResults = [:]
    }
}

struct SimpleAnalyseView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleAnalyseView(viewModel: SimpleAnalyseViewModel())
    }
}
