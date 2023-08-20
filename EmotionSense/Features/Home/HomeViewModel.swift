//
//  HomeViewModel.swift
//  EmotionSense
//
//  Created by Kristina Motte on 07/07/2023.
//

import Foundation
import CoreML
import NaturalLanguage

final class HomeViewModel: ObservableObject {
    let menuItems: [MenuItem] = MenuItem.allCases
}
