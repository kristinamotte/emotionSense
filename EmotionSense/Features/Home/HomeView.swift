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
        .onAppear {
            viewModel.predict()
        }
    }
    
    var SidebarContent: some View {
        List(selection: $selectedMenuItem) {
            link(to: .home)
            link(to: .simple)
            link(to: .file)
            link(to: .drafts)
        }
    }
    
    @ViewBuilder
    var detailContent: some View {
        switch selectedMenuItem {
        case .home:
            Text(selectedMenuItem.name)
        case .simple:
            Text(selectedMenuItem.name)
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
            }
        }
        .padding(.vertical, 12)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
