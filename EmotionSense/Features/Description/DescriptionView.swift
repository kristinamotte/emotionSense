//
//  DescriptionView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 24/08/2023.
//

import SwiftUI

struct DescriptionView: View {
    let onSimpleAnalyze: (() -> Void)?
    let onFileAnalyze: (() -> Void)?
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                Content
                    .frame(maxWidth: 570)
                Spacer()
            }
            Spacer()
        }
        .padding(.leading, 40)
        .padding(.top, 56)
    }
    
    var Content: some View {
        VStack(alignment: .leading, spacing: 24.0) {
            VStack(alignment: .leading, spacing: 16.0) {
                Group {
                    Text("Welcome to ")
                        .bold24TextBlack +
                    Text("EmotionSense")
                        .bold24Blue +
                    Text(" App!")
                        .bold24TextBlack
                }
                Text("Explore the world of emotions within text using our powerful desktop app. Whether you're analyzing a small snippet or delving into a vast collection of phrases, our app offers two intuitive methods for emotion analysis:")
                    .regular14DarkGrey
                    .lineSpacing(6)
            }
            HStack(alignment: .top, spacing: 16) {
                AnalyseTypeView(title: "Quick Analysis", description: "Enter up to 300 words in the input field, and witness instant insights into the emotional tone of the text. Discover joy, sadness, anger, and more, as our app accurately detects emotions to give you a comprehensive overview.", backgroundColor: Color(Colors.lightBg), onAction: onSimpleAnalyze)
                AnalyseTypeView(title: "Bulk Upload", description: "Have a treasure trove of text waiting to be explored? Upload your file containing numerous phrases, and let our app process and analyze them in no time. The results are saved directly to your device, enabling you to refer back to your results.", backgroundColor: Color(Colors.yellowBg), onAction: onFileAnalyze)
            }
        }
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(onSimpleAnalyze: nil, onFileAnalyze: nil)
    }
}
