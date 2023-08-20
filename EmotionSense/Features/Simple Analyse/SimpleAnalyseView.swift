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
    @StateObject private var inputBindingManager = InputBindingManager(limit: 50)
    
    var body: some View {
        HStack(spacing: .zero) {
            VStack(alignment: .leading, spacing: 24.0) {
                Description
                InputField
            }
            Spacer()
        }
        .padding(.leading, 40)
        .padding(.top, 56)
        .onChange(of: inputBindingManager.input) { text in
            viewModel.numberOfChars = text.count
        }
    }
    
    var Description: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Analyse simple text")
                .bold24TextBlack
            Text("Here you can quickly analyse small text to try out our product or if you doesn’t want to waste time on file creation")
                .regular14DarkGreyMultiline
                .lineSpacing(6)
        }
        .frame(maxWidth: 540)
    }
    
    var InputField: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextEditor(text: $inputBindingManager.input)
                .font(.custom(Fonts.Raleway.semiBold.rawValue, size: 14))
                .foregroundColor(Color(Colors.textBlack))
                .padding(.all, 16)
                .border(Color(Colors.borderGrey), width: 2.0)
                .cornerRadius(5.0)
                .frame(minWidth: 540, maxWidth: 540, maxHeight: 165)
                .disabled(viewModel.isAnalysed)
                .onChange(of: inputBindingManager.input, perform: editingChanged)
            HStack(alignment: .center, spacing: .zero) {
                CharactersLimit
                Spacer()
                Button {
                    viewModel.isAnalysed = true
                } label: {
                    ButtonContent
                        .frame(maxWidth: 170)
                        .modifier(ViewModifiers.defaultButtonHeight)
                }
                .buttonStyle(ButtonStyles.defaultNormal)
                .disabled(viewModel.isAnalysed)
            }
            Spacer()
        }
        .frame(maxWidth: 540)
    }
    
    @ViewBuilder var ButtonContent: some View {
        if viewModel.isAnalysed {
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
                Text("/50 chars")
            }
        }
    }
    
    // MARK: - Private
    private func editingChanged(_ value: String) {
        inputBindingManager.input = String(value.prefix(inputBindingManager.characterLimit))
    }
}

struct SimpleAnalyseView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleAnalyseView(viewModel: SimpleAnalyseViewModel())
    }
}
