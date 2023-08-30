//
//  FileAnalyseDetailsView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 29/08/2023.
//

import SwiftUI

struct FileAnalyseDetailsView: View {
    let text: EmotionTextList
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: Dimensions.padding16) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack(alignment: .center, spacing: Dimensions.padding12) {
                    Image("ic_return_back")
                    Text("return back")
                        .regular14DarkGrey
                }
            }
            .buttonStyle(PlainButtonStyle())
            Text(text.title)
        }
    }
}

struct FileAnalyseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FileAnalyseDetailsView(text: EmotionTextList())
    }
}
