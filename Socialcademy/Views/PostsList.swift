//
//  PostsList.swift
//  Socialcademy
//
//  Created by schork on 11/06/24.
//

import SwiftUI

struct PostsList: View {
    @StateObject var viewModel: PostsViewModel
    
    @State private var searchText = ""
    @State private var showNewPostForm = false
    
    var body: some View {
        Group {
            switch viewModel.posts {
            case .loading:
                ProgressView()
            case let .error(error):
                EmptyListView(
                    title: "Cannot Load Posts",
                    message: error.localizedDescription,
                    retryAction: {
                        viewModel.fetchPosts()
                    }
                )
            case .empty:
                EmptyListView(
                    title: "No Posts",
                    message: "There aren’t any posts yet."
                )
            case let .loaded(posts):
                ScrollView {
                    ForEach(posts) { post in
                        if searchText.isEmpty || post.contains(searchText) {
                            PostRow(viewModel: viewModel.makePostRowViewModel(for: post))
                        }
                    }
                    .searchable(text: $searchText)
                    .animation(.default, value: posts)
                }
            }
        }
        .navigationTitle(viewModel.title)
        .onAppear {
            viewModel.fetchPosts()
        }
        .sheet(isPresented: $showNewPostForm) {
            NewPostForm(viewModel: viewModel.makeNewPostViewModel())
        }
        .toolbar {
            Button {
                showNewPostForm = true
            } label: {
                Label("New Post", systemImage: "square.and.pencil")
            }
        }
    }
}
