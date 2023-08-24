//
//  EmotionSenseApp.swift
//  EmotionSense
//
//  Created by Kristina Motte on 07/07/2023.
//

import SwiftUI

@main
struct EmotionSenseApp: App {
    let persistanceController: PersistanceController = .shared
    private let predictionManager: PredictionManager = .shared
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
                .environment(\.managedObjectContext, persistanceController.container.viewContext)
                .preferredColorScheme(.light)
        }
    }
}
