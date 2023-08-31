//
//  AddNewFileViewModel.swift
//  EmotionSense
//
//  Created by Kristina Motte on 31/08/2023.
//

import Foundation

final class AddNewFileViewModel: ObservableObject {
    @Published var analyseName: String = ""
    @Published var fileUrl: URL?
    @Published var fileName: String?
    @Published var isFileParsingInProgress: Bool = false
    @Published var shouldNavigateToDetails: Bool = false
    @Published var failedToParseData: Bool = false
    @Published var texts: [String] = []
    
    func analyseAndNavigate() {
        isFileParsingInProgress = true
        
        if let fileUrl = fileUrl {
            paragraphs(from: fileUrl) { parsedData in
                if let parsedData = parsedData {
                    let uniqueParsedData = Set(parsedData)
                    self.texts = Array(uniqueParsedData)
                    self.isFileParsingInProgress = false
                    self.shouldNavigateToDetails = true
                } else {
                    self.isFileParsingInProgress = false
                    self.failedToParseData = true
                }
            }
        } else {
            failedToParseData = true
        }
    }
    
    func cleanUpAll() {
        analyseName = ""
        fileUrl = nil
        fileName = nil
        isFileParsingInProgress = false
        shouldNavigateToDetails = false
        texts = []
    }
    
    // MARK: - Helpers
    func paragraphs(from url: URL, completion: @escaping ([String]?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                // Load the content of the .rtf file into an NSAttributedString
                let attributedString = try NSAttributedString(url: url, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                
                // Convert the NSAttributedString into a String
                let plainString = attributedString.string
                
                // Split the string based on double newlines to get an array of paragraphs
                let paragraphs = plainString.components(separatedBy: "\n\n")
                
                DispatchQueue.main.async {
                    completion(paragraphs)
                }
            } catch {
                print("Error reading file: \(error)")
                
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
