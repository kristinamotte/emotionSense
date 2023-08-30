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
    
    var body: some View {
        HStack(spacing: .zero) {
            VStack(spacing: .zero) {
                if textList.isEmpty {
                    FileAnalyseEmptyView {
                        // Add new analyse
                    }
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
            Button {
                // Add new analyse
            } label: {
                HStack(alignment: .center, spacing: Dimensions.padding16) {
                    Image("ic_add")
                    Text("New analyse")
                }
                .padding(.horizontal, Dimensions.padding16)
                .modifier(ViewModifiers.defaultButtonHeight)
            }
            .buttonStyle(ButtonStyles.lightNormal)
        }
    }
    
    var GridView: some View {
        ScrollView {
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
        }
    }
    
    func GridItemView(item: EmotionTextList) -> some View {
        NavigationLink {
            FileAnalyseDetailsView(text: item)
        } label: {
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
