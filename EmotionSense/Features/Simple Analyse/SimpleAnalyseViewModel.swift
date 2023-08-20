//
//  SimpleAnalyseViewModel.swift
//  EmotionSense
//
//  Created by Kristina Motte on 19/08/2023.
//

import SwiftUI

final class SimpleAnalyseViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var isAnalysed: Bool = false
    @Published var numberOfChars: Int = .zero
}
