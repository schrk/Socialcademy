//
//  User.swift
//  Socialcademy
//
//  Created by Havan on 13/06/24.
//

import Foundation

struct User: Identifiable, Equatable, Codable {
    var id: String
    var name: String
}

extension User {
    static let testUser = User(id: "", name: "Jamie Harris")
}
