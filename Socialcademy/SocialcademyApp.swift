//
//  SocialcademyApp.swift
//  Socialcademy
//
//  Created by Enzo Schork on 08/01/24.
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
            ContentView()
        }
    }
}
