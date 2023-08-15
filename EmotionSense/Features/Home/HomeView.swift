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
            ForEach(viewModel.menuItems, id: \.self) { item in
                link(to: item)
            }
            .listRowBackground(Color(#colorLiteral(red: 0.8831247687, green: 0.9257313609, blue: 0.9948113561, alpha: 1)))
        }
        .toolbarBackground(Color.clear, for: .windowToolbar)
        .background(Color(#colorLiteral(red: 0.8831247687, green: 0.9257313609, blue: 0.9948113561, alpha: 1)))
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
                    .foregroundColor(selectedMenuItem == page ? Color.blue : Color.black)
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
