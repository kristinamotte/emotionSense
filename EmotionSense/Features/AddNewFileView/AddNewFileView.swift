//
//  AddNewFileView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 31/08/2023.
//

import SwiftUI

struct AddNewFileView: View {
    @ObservedObject var viewModel: AddNewFileViewModel
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .center, spacing: .zero) {
                VStack(alignment: .leading, spacing: Dimensions.padding24) {
                    Text("Upload file")
                        .bold24TextBlack
                    Content
                    Spacer()
                }
                Spacer()
            }
            .padding(.leading, Dimensions.padding40)
            .padding(.top, Dimensions.padding56)
            .onAppear {
                viewModel.cleanUpAll()
            }
            .navigationDestination(isPresented: $viewModel.shouldNavigateToDetails) {
                AnalyseFileDetailsView(viewModel: AnalyseFileDetailsViewModel(title: viewModel.analyseName, textList: viewModel.texts, shouldNavigateToDetails: $viewModel.shouldNavigateToDetails))
            }
        }
    }
    
    var Content: some View {
        VStack(alignment: .leading, spacing: Dimensions.padding16) {
            TextField("Name your analyse", text: $viewModel.analyseName)
                .font(.custom(Fonts.Raleway.semiBold.rawValue, size: 14))
                .foregroundColor(Color(Colors.textBlack))
                .padding(.all, Dimensions.padding16)
                .border(Color(Colors.borderGrey), width: 2.0)
                .cornerRadius(Dimensions.cornerRadius / 2)
                .frame(minWidth: Dimensions.maxContentSize, maxWidth: Dimensions.maxContentSize, maxHeight: 40)
                .textFieldStyle(.plain)
            VStack(alignment: .trailing, spacing: Dimensions.padding16) {
                FileUpload
                if viewModel.fileUrl != nil {
                    HStack(alignment: .center, spacing: Dimensions.padding8) {
                        if viewModel.failedToParseData {
                            Text("Failed to parse your file data. Please review your file.")
                                .regular14Red
                        }
                        Button {
                            viewModel.analyseAndNavigate()
                        } label: {
                            ButtonContent
                                .frame(maxWidth: 170)
                                .modifier(ViewModifiers.defaultButtonHeight)
                        }
                        .buttonStyle(ButtonStyles.defaultNormal)
                        .disabled(viewModel.analyseName.isEmpty || viewModel.isFileParsingInProgress)
                    }
                }
            }
        }
    }
    
    var FileUpload: some View {
        Button {
            let panel = NSOpenPanel()
            panel.allowsMultipleSelection = false
            panel.canChooseDirectories = false
            panel.allowedContentTypes = [.text]
            
            if panel.runModal() == .OK {
                viewModel.fileUrl = panel.url
                viewModel.fileName = panel.url?.lastPathComponent
            }
        } label: {
            VStack(alignment: .center, spacing: Dimensions.padding8) {
                if let fileName = viewModel.fileName {
                    Image("ic_selectedFile")
                    Text(fileName)
                        .regular14DarkBlack
                        .lineLimit(1)
                } else {
                    Image("ic_addFile")
                    Text("Select your txt file")
                        .regular14Blue
                }
            }
        }
        .buttonStyle(.plain)
        .disabled(viewModel.fileUrl != nil)
        .frame(maxWidth: Dimensions.maxContentSize, maxHeight: 120)
        .background(RoundedRectangle(cornerRadius: Dimensions.cornerRadius)
            .fill(Color(Colors.lightBg)))
    }
    
    @ViewBuilder var ButtonContent: some View {
        if viewModel.isFileParsingInProgress {
            ProgressView()
                .colorInvert()
                .brightness(1)
                .scaleEffect(x: 0.5, y: 0.5, anchor: .center)
        } else {
            Text("Analyse")
        }
    }
}

struct AddNewFileView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewFileView(viewModel: AddNewFileViewModel())
    }
}
