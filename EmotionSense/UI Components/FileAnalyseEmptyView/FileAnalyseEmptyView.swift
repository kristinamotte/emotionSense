//
//  FileAnalyseEmptyView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 29/08/2023.
//

import SwiftUI

struct FileAnalyseEmptyView: View {
    let onAction: (() -> Void)?
    
    var body: some View {
        HStack(spacing: .zero) {
            Spacer()
            VStack(alignment: .center, spacing: Dimensions.padding24) {
                Image("ic_file_empty")
                Text("Currently, you don't have any analyzed texts")
                    .regular16Black
                Button {
                    onAction?()
                } label: {
                    HStack(alignment: .center, spacing: Dimensions.padding16) {
                        Image("ic_add")
                        Text("New analyse")
                    }
                    .padding(.horizontal, Dimensions.padding16)
                    .modifier(ViewModifiers.defaultButtonHeight)
                }
                .buttonStyle(ButtonStyles.lightNormal)
            }
            Spacer()
        }
    }
}

struct FileAnalyseEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        FileAnalyseEmptyView(onAction: nil)
    }
}
