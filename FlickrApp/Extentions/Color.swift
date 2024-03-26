//
//  Color.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 13/02/2024.
//

import SwiftUI
extension Color {
    init(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        var rgb: UInt64 = 0
        
        // Convert the hexadecimal string to a 64-bit unsigned integer
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        // Extract the red, green, and blue components
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        // Initialize the Color with the RGB components
        self.init(red: red, green: green, blue: blue)
    }
}

extension Color {
    
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
    
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let secondaryBackground = Color("SecondaryBackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    
}

struct ColorTheme2 {
    let accent = Color(#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1))
    let background = Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))
    let green = Color(#colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1))
    let red = Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1))
    let secondaryText = Color(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1))
}

struct LaunchTheme {
    
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
    
}
