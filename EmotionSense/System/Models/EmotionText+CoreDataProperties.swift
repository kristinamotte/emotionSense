//
//  EmotionText+CoreDataProperties.swift
//  EmotionSense
//
//  Created by Kristina Motte on 24/08/2023.
//
//

import Foundation
import CoreData

extension EmotionText {
    @NSManaged public var text: String
    @NSManaged public var analysedResults: [TextAnalyse]
    @NSManaged public var list: EmotionTextList
}

// MARK: Generated accessors for analysedResults
extension EmotionText {
    @objc(insertObject:inAnalysedResultsAtIndex:)
    @NSManaged public func insertIntoAnalysedResults(_ value: TextAnalyse, at idx: Int)

    @objc(removeObjectFromAnalysedResultsAtIndex:)
    @NSManaged public func removeFromAnalysedResults(at idx: Int)

    @objc(insertAnalysedResults:atIndexes:)
    @NSManaged public func insertIntoAnalysedResults(_ values: [TextAnalyse], at indexes: NSIndexSet)

    @objc(removeAnalysedResultsAtIndexes:)
    @NSManaged public func removeFromAnalysedResults(at indexes: NSIndexSet)

    @objc(replaceObjectInAnalysedResultsAtIndex:withObject:)
    @NSManaged public func replaceAnalysedResults(at idx: Int, with value: TextAnalyse)

    @objc(replaceAnalysedResultsAtIndexes:withAnalysedResults:)
    @NSManaged public func replaceAnalysedResults(at indexes: NSIndexSet, with values: [TextAnalyse])

    @objc(addAnalysedResultsObject:)
    @NSManaged public func addToAnalysedResults(_ value: TextAnalyse)

    @objc(removeAnalysedResultsObject:)
    @NSManaged public func removeFromAnalysedResults(_ value: TextAnalyse)

    @objc(addAnalysedResults:)
    @NSManaged public func addToAnalysedResults(_ values: NSOrderedSet)

    @objc(removeAnalysedResults:)
    @NSManaged public func removeFromAnalysedResults(_ values: NSOrderedSet)
}

extension EmotionText: Identifiable {

}
