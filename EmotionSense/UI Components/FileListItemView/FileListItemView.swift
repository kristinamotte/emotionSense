//
//  FileListItemView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 29/08/2023.
//

import SwiftUI

struct FileListItemView: View {
    let title: String
    let date: String
    
    var body: some View {
        HStack(alignment: .center, spacing: Dimensions.padding8) {
            VStack(alignment: .leading, spacing: Dimensions.padding8) {
                Text(title)
                    .bold16TextBlack
                    .lineLimit(1)
                Text(date)
                    .regular14DarkGrey
            }
            Spacer()
            Image("ic_round_arrow")
        }
        .padding(.all, Dimensions.padding16)
        .background(RoundedRectangle(cornerRadius: Dimensions.cornerRadius).fill(Color(Colors.lightBg)))
        .frame(minWidth: 277, maxWidth: 277, maxHeight: 80)
    }
}

struct FileListItemView_Previews: PreviewProvider {
    static var previews: some View {
        FileListItemView(title: "Title example", date: "today")
    }
}
