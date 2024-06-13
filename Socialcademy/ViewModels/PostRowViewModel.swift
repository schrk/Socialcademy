//
//  PostRowViewModel.swift
//  Socialcademy
//
//  Created by schork on 12/06/24.
//

import Foundation

@MainActor
@dynamicMemberLookup
class PostRowViewModel: ObservableObject {
    @Published var post: Post
    @Published var error: Error?
    
    typealias Action = () async throws -> Void
    
    var canDeletePost: Bool { deleteAction != nil }
    
    private let deleteAction: Action?
    private let favoriteAction: Action
    
    subscript<T>(dynamicMember keyPath: KeyPath<Post, T>) -> T {
        post[keyPath: keyPath]
    }
    
    init(post: Post, deleteAction: Action?, favoriteAction: @escaping Action) {
        self.post = post
        self.deleteAction = deleteAction
        self.favoriteAction = favoriteAction
    }
}

extension PostRowViewModel {
    func deletePost() {
        guard let deleteAction = deleteAction else {
            preconditionFailure("Cannot delete post: no delete action provided")
        }
        withErrorHandlingTask(perform: deleteAction)
    }

    func favoritePost() {
        withErrorHandlingTask(perform: favoriteAction)
    }
    
    private func withErrorHandlingTask(perform action: @escaping Action) {
        Task {
            do {
                try await action()
            } catch {
                print("[PostRowViewModel] Error: \(error)")
                self.error = error
            }
        }
    }
}
