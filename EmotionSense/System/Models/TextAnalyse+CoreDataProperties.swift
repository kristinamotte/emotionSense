//
//  TextAnalyse+CoreDataProperties.swift
//  EmotionSense
//
//  Created by Kristina Motte on 24/08/2023.
//
//

import Foundation
import CoreData


extension TextAnalyse: Identifiable {
    @NSManaged public var emotion: String
    @NSManaged public var probability: Double
    @NSManaged public var texts: EmotionText
}

extension Array where Iterator.Element == TextAnalyse {
    var toDictionary: [String: Double] {
        var result: [String: Double] = [:]
        
        forEach { element in
            result[element.emotion] = element.probability
        }
        
        return result
    }
}
