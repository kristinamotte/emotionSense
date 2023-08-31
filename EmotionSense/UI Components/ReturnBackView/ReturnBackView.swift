//
//  ReturnBackView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 31/08/2023.
//

import SwiftUI

struct ReturnBackView: View {
    let onAction: (() -> Void)?
    
    var body: some View {
        Button {
            onAction?()
        } label: {
            HStack(alignment: .center, spacing: Dimensions.padding12) {
                Image("ic_return_back")
                Text("return back")
                    .regular14DarkGrey
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ReturnBackView_Previews: PreviewProvider {
    static var previews: some View {
        ReturnBackView(onAction: nil)
    }
}
