//
//  ListPreview.swift
//  Socialcademy
//
//  Created by Enzo Schork on 09/01/24.
//

import Foundation
import SwiftUI

@MainActor
private struct ListPreview: View {
    let state: Loadable<[Post]>
    
    var body: some View {
        let postsRepository = PostsRepositoryStub(state: state)
        let viewModel = PostsViewModel(postsRepository: postsRepository)
        PostsList(viewModel: viewModel)
    }
}
