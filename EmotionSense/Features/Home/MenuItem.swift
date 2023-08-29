//
//  MenuItem.swift
//  EmotionSense
//
//  Created by Kristina Motte on 12/08/2023.
//

import Foundation

enum MenuItem: CaseIterable, Identifiable {
    var id: Self {
        self
    }
    
    case home
    case simple
    case file
    
    var name: String {
        switch self {
        case .home:
            return "Home"
        case .simple:
            return "Simple analyse"
        case .file:
            return "File analyse"
        }
    }
    
    var imageName: String {
        switch self {
        case .home:
            return "ic_home"
        case .simple:
            return "ic_simple"
        case .file:
            return "ic_file"
        }
    }
    
    var selectedImageName: String {
        switch self {
        case .home:
            return "ic_home_selected"
        case .simple:
            return "ic_simple_selected"
        case .file:
            return "ic_file_selected"
        }
    }
}
