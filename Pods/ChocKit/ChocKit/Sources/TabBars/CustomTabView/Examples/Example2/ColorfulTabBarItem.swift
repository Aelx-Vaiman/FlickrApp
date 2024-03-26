//
//  File.swift
//  Vardiac
//
//  Created by Alex Vaiman on 06/03/2024.
//

import SwiftUI

enum ColorfulTabBarItem: Hashable, CaseIterable {

    case home, favorites, profile, messages

    var iconName: String {
        switch self {
        case .home: return "house"
        case .favorites: return "heart"
        case .profile: return "person"
        case .messages: return "message"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Favorites"
        case .profile: return "Profile"
        case .messages: return "Messages"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return Color.red
        case .favorites: return Color.blue
        case .profile: return Color.green
        case .messages: return Color.orange
        }
    }
}


