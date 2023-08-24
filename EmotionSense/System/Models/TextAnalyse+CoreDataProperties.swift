//
//  TextAnalyse+CoreDataProperties.swift
//  EmotionSense
//
//  Created by Kristina Motte on 24/08/2023.
//
//

import Foundation
import CoreData


extension TextAnalyse {
    @NSManaged public var emotion: String
    @NSManaged public var probability: Double
    @NSManaged public var texts: EmotionText
}

extension TextAnalyse : Identifiable {

}
