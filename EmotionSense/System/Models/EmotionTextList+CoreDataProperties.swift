//
//  EmotionTextList+CoreDataProperties.swift
//  EmotionSense
//
//  Created by Kristina Motte on 24/08/2023.
//
//

import Foundation
import CoreData


extension EmotionTextList: Identifiable {
    @NSManaged public var dateAdded: Date
    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var texts: [EmotionText]
}

// MARK: Generated accessors for texts
extension EmotionTextList {
    @objc(addTextsObject:)
    @NSManaged public func addToTexts(_ value: EmotionText)

    @objc(removeTextsObject:)
    @NSManaged public func removeFromTexts(_ value: EmotionText)

    @objc(addTexts:)
    @NSManaged public func addToTexts(_ values: NSSet)

    @objc(removeTexts:)
    @NSManaged public func removeFromTexts(_ values: NSSet)
}

extension EmotionTextList {
    var dateForDisplay: String {
        let calendar = Calendar.current
        let today = Date.now
        
        if calendar.isDateInToday(dateAdded) {
            return "today"
        } else if calendar.isDateInYesterday(dateAdded) {
            return "yesterday"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM"
            
            return formatter.string(from: dateAdded)
        }
    }
}
