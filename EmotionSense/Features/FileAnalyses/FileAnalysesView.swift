//
//  FileAnalysesView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 24/08/2023.
//

import SwiftUI
import CoreData

struct FileAnalysesView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: EmotionTextList.entity(), sortDescriptors: [NSSortDescriptor(key: "dateAdded", ascending: false)])
    var textList: FetchedResults<EmotionTextList>
    
    // MARK: - State
    @State private var path: [EmotionTextList] = []
    
    var body: some View {
        HStack(spacing: .zero) {
            VStack(spacing: .zero) {
                if textList.isEmpty {
                    FileAnalyseEmptyView(destination: AddNewFileView(viewModel: AddNewFileViewModel()))
                } else {
                    VStack(alignment: .leading, spacing: Dimensions.padding20) {
                        Header
                            .frame(maxWidth: 578)
                        GridView
                    }
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.leading, Dimensions.padding40)
        .padding(.top, Dimensions.padding56)
    }
    
    var Header: some View {
        HStack(alignment: .center, spacing: .zero) {
            Text("File analyse")
                .bold24TextBlack
            Spacer()
        }
    }
    
    var GridView: some View {
        ScrollView {
            NavigationStack(path: $path) {
                VStack(spacing: Dimensions.padding16) {
                    ForEach(0..<(textList.count + 1) / 2, id: \.self) { rowIndex in
                        HStack(spacing: Dimensions.padding24) {
                            GridItemView(item: textList[rowIndex * 2])
                            if rowIndex * 2 + 1 < textList.count {
                                GridItemView(item: textList[rowIndex * 2 + 1])
                            } else {
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                }
                .navigationDestination(for: EmotionTextList.self) { item in
                    FileAnalyseDetailsView(text: item)
                }
            }
        }
    }
    
    func GridItemView(item: EmotionTextList) -> some View {
        NavigationLink(value: item) {
            FileListItemView(title: item.title, date: item.dateForDisplay)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct FileAnalysesView_Previews: PreviewProvider {
    static var previews: some View {
        FileAnalysesView()
    }
}
