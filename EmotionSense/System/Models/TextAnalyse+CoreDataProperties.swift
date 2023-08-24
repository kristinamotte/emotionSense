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
    @nonobjc class func fetchRequest() -> NSFetchRequest<TextAnalyse> {
        NSFetchRequest<TextAnalyse>(entityName: "EmotionAnalyse")
    }

    @NSManaged var emotion: String?
    @NSManaged var probability: Double
}

extension TextAnalyse: Identifiable {

}
