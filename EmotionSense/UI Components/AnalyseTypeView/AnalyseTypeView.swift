//
//  AnalyseTypeView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 24/08/2023.
//

import SwiftUI

struct AnalyseTypeView: View {
    let title: String
    let description: String
    let backgroundColor: Color
    let onAction: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: Dimensions.padding16) {
            Text(title)
                .bold16TextBlack
            Text(description)
                .regular14BlackMultiline
                .lineSpacing(Dimensions.defaultLineSpacing)
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
        .padding(.all, Dimensions.padding16)
        .background(RoundedRectangle(cornerRadius: Dimensions.padding16).fill(backgroundColor))
    }
}

struct AnalyseTypeView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyseTypeView(title: "Quick Analysis", description: "Enter up to 300 words in the input field, and witness instant insights into the emotional tone of the text. Discover joy, sadness, anger, and more, as our app accurately detects emotions to give you a comprehensive overview.", backgroundColor: Color(Colors.yellowBg), onAction: nil)
    }
}
