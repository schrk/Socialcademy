//
//  ProfileView.swift
//  Socialcademy
//
//  Created by Havan on 13/06/24.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    var body: some View {
        Button("Sign Out", action: {
            try! Auth.auth().signOut()
        })
    }
}
