//
//  EmotionType.swift
//  EmotionSense
//
//  Created by Kristina Motte on 06/08/2023.
//

import Foundation

enum EmotionType: String, CaseIterable {
    case disgust
    case sadness
    case relief
    case caring
    case grief
    case optimism
    case remorse
    case curiosity
    case approval
    case love
    case annoyance
    case neutral
    case excitement
    case fear
    case joy
    case anger
    case realization
    case pride
    case surprise
    case gratitude
    case embarrassment
    case disapproval
    case nervousness
    case amusement
    case confusion
    case disappointment
    case desire
    case admiration
    case unknown
    
    var emoji: String {
        switch self {
        case .disgust:
            return "😖"
        case .sadness:
            return "😢"
        case .relief:
            return "😌"
        case .caring:
            return "🤗"
        case .grief:
            return "😔"
        case .optimism:
            return "😄"
        case .remorse:
            return "😞"
        case .curiosity:
            return "🤔"
        case .approval:
            return "👍"
        case .love:
            return "❤️"
        case .annoyance:
            return "😒"
        case .neutral:
            return "😐"
        case .excitement:
            return "😃"
        case .fear:
            return "😨"
        case .joy:
            return "😂"
        case .anger:
            return "😡"
        case .realization:
            return "😲"
        case .pride:
            return "🏆"
        case .surprise:
            return "😮"
        case .gratitude:
            return "🙏"
        case .embarrassment:
            return "😳"
        case .disapproval:
            return "👎"
        case .nervousness:
            return "😬"
        case .amusement:
            return "😄"
        case .confusion:
            return "😕"
        case .disappointment:
            return "😞"
        case .desire:
            return "😍"
        case .admiration:
            return "😊"
        case .unknown:
            return "❓"
        }
    }
    
    var isPositiveEmotion: Bool {
        switch self {
        case .disgust, .sadness, .grief, .remorse, .annoyance, .fear, .anger, .nervousness, .confusion, .disappointment, .unknown:
            return false
        default:
            return true
        }
    }
}
