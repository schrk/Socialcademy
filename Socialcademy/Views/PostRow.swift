//
//  PostRow.swift
//  Socialcademy
//
//  Created by schork on 11/06/24.
//

import SwiftUI

struct PostRow: View {
    @ObservedObject var viewModel: PostRowViewModel
    
    @State private var showConfirmationDialog = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: .zero) {
                AuthorView(author: viewModel.author)
                
                Spacer()
                
                Text(viewModel.timestamp.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
            }
            .foregroundColor(.gray)
            
            Text(viewModel.title)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(viewModel.content)
            
            HStack {
                FavoriteButton(isFavorite: viewModel.isFavorite) {
                    viewModel.favoritePost()
                }
                
                Spacer()
                
                if viewModel.canDeletePost {
                    Button(role: .destructive, action: {
                        showConfirmationDialog = true
                    }) {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .labelStyle(.iconOnly)
            .buttonStyle(.borderless)
        }
        .confirmationDialog("Are you sure you want to delete this post?", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                viewModel.deletePost()
            }
        }
        .alert("Cannot Delete Post", error: $viewModel.error)
        .padding()
    }
}

private extension PostRow {
    struct FavoriteButton: View {
        let isFavorite: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                if isFavorite {
                    Label("Remove from Favorites", systemImage: "heart.fill")
                } else {
                    Label("Add to Favorites", systemImage: "heart")
                }
            }
            .foregroundColor(isFavorite ? .red : .gray)
            .animation(.default, value: isFavorite)
        }
    }
    
    struct AuthorView: View {
        let author: User
        
        @EnvironmentObject private var factory: ViewModelFactory
        
        var body: some View {
            NavigationLink {
                PostsList(viewModel: factory.makePostsViewModel(filter: .author(author)))
            } label: {
                Text(author.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
    }
}
