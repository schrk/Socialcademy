//
//  MainTabView.swift
//  Socialcademy
//
//  Created by schork on 13/06/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var factory: ViewModelFactory
    
    var body: some View {
        TabView {
            NavigationView {
                PostsList(viewModel: factory.makePostsViewModel())
            }
            .tabItem {
                Label("Posts", systemImage: "list.dash")
            }
            NavigationView {
                PostsList(viewModel: factory.makePostsViewModel(filter: .favorites))
            }
            .tabItem {
                Label("Favorites", systemImage: "heart")
            }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}
