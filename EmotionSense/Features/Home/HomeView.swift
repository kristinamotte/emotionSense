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
            NavigationStack {
                detailContent
            }
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
        .padding(.leading, Dimensions.padding16)
        .background(Color(Colors.lightGrey))
    }
    
    @ViewBuilder
    var detailContent: some View {
        switch selectedMenuItem {
        case .home:
            DescriptionView {
                selectedMenuItem = .simple
            } onFileAnalyze: {
                selectedMenuItem = .addNew
            }
        case .simple:
            SimpleAnalyseView(viewModel: SimpleAnalyseViewModel())
        case .file:
            FileAnalysesView()
        case .addNew:
            AddNewFileView(viewModel: AddNewFileViewModel())
        }
    }
    
    func link(to page: MenuItem) -> some View {
        NavigationLink(value: page) {
            menuItemContent(for: page)
                .listRowSeparator(.hidden)
        }
        .padding(.vertical, 12)
    }
    
    @ViewBuilder func menuItemContent(for page: MenuItem) -> some View {
        if page == .addNew {
            HStack(alignment: .center, spacing: Dimensions.padding16) {
                Image("ic_add")
                Text("New analyse")
                    .semiBold14Blue
            }
            .padding(.horizontal, Dimensions.padding16)
            .modifier(ViewModifiers.defaultButtonHeight)
            .background(RoundedRectangle(cornerRadius: .infinity)).foregroundColor(Color(Colors.lightBlueBg))
        } else {
            HStack(alignment: .center, spacing: Dimensions.padding8) {
                Image(selectedMenuItem == page ? page.selectedImageName : page.imageName)
                Text(page.name)
                    .semiBold14(with: selectedMenuItem == page ? Color(Colors.blue) : Color(Colors.darkGrey))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
