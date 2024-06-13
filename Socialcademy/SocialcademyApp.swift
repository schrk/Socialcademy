//
//  SocialcademyApp.swift
//  Socialcademy
//
//  Created by schork on 11/06/24.
//

import SwiftUI
import Firebase

@main
struct SocialcademyApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
