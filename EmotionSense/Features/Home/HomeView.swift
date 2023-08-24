//
//  HomeView.swift
//  EmotionSense
//
//  Created by Kristina Motte on 07/07/2023.
//

import SwiftUI

struct HomeView: View {
    let viewModel: HomeViewModel
    
    // MARK: States
    @State private var selectedMenuItem: MenuItem = .home
    
    var body: some View {
        NavigationSplitView {
            SidebarContent
        } detail: {
            detailContent
        }
        .navigationSplitViewStyle(.balanced)
        .background(Color.white)
    }
    
    var SidebarContent: some View {
        List(selection: $selectedMenuItem) {
            ForEach(viewModel.menuItems, id: \.self) { item in
                link(to: item)
            }
            .listRowBackground(Color(Colors.lightGrey))
        }
        .toolbarBackground(Color.clear, for: .windowToolbar)
        .padding(.leading, 16)
        .background(Color(Colors.lightGrey))
    }
    
    @ViewBuilder
    var detailContent: some View {
        switch selectedMenuItem {
        case .home:
            DescriptionView {
                selectedMenuItem = .simple
            } onFileAnalyze: {
                selectedMenuItem = .file
            }
        case .simple:
            SimpleAnalyseView(viewModel: SimpleAnalyseViewModel())
        case .file:
            Text(selectedMenuItem.name)
        case .drafts:
            Text(selectedMenuItem.name)
        }
    }
    
    func link(to page: MenuItem) -> some View {
        NavigationLink(value: page) {
            HStack(alignment: .center, spacing: 8) {
                Image(selectedMenuItem == page ? page.selectedImageName : page.imageName)
                Text(page.name)
                    .semiBold14(with: selectedMenuItem == page ? Color(Colors.blue) : Color(Colors.darkGrey))
                
            }
            .listRowSeparator(.hidden)
        }
        .padding(.vertical, 12)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
