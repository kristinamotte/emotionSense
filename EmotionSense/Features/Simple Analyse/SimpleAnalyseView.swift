//
//  SimpleAnalyseView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 19/08/2023.
//

import SwiftUI

struct SimpleAnalyseView: View {
    @ObservedObject var viewModel: SimpleAnalyseViewModel
    
    var body: some View {
        HStack(spacing: .zero) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Analyse simple text")
                    .bold24TextBlack
                Text("Here you can quickly analyse small text to try out our product or if you doesn’t want to waste time on file creation")
                    .regular14DarkGreyMultiline
                    .lineSpacing(6)
                Spacer()
            }
            .frame(maxWidth: 540)
            .padding(.leading, 40)
            .padding(.top, 56)
            Spacer()
        }
    }
}

struct SimpleAnalyseView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleAnalyseView(viewModel: SimpleAnalyseViewModel())
    }
}
