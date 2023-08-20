//
//  EmotionSenseApp.swift
//  EmotionSense
//
//  Created by Kristina Motte on 07/07/2023.
//

import SwiftUI

@main
struct EmotionSenseApp: App {
    private let predictionManager: PredictionManager = .shared
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
                .preferredColorScheme(.light)
        }
    }
}
