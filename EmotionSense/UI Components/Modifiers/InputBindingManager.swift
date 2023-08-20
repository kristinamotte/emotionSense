//
//  InputBindingManager.swift
//  EmotionSense
//
//  Created by Kristina Motte on 20/08/2023.
//

import SwiftUI

final class InputBindingManager: ObservableObject {
    // MARK: - Dependencies
    @Published var input = ""
    
    // MARK: - Constants
    let characterLimit: Int
    
    // MARK: - Init
    init(limit: Int) {
        characterLimit = limit
    }
}
