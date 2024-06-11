//
//  PostsViewModel.swift
//  Socialcademy
//
//  Created by Havan on 11/06/24.
//

import Foundation

@MainActor
class PostsViewModel: ObservableObject {
    @Published var posts = [Post.testPost]
    
    func makeCreateAction() -> NewPostForm.CreateAction {
        return { [weak self] post in
            self?.posts.insert(post, at: 0)
        }
    }
}
