//
//  Color.swift
//  ChocKit
//
//  Created by Alex Vaiman on 10/03/2024.
//

import SwiftUI

public extension Color {
    func blendedWithWhiteOpacity(_ opacity: Double) -> Color {
        let opacity = 1 - opacity
        // Extracting color components
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        UIColor(self).getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        
        // Calculating blended color components
        let r2: CGFloat = 1, g2: CGFloat = 1, b2: CGFloat = 1, a2: CGFloat = CGFloat(opacity)
        let r = (1 - a2) * r1 + a2 * r2
        let g = (1 - a2) * g1 + a2 * g2
        let b = (1 - a2) * b1 + a2 * b2
        let a = (1 - a2) * a1 + a2 * a2
        
        // Creating the resulting color
        return Color(red: Double(r), green: Double(g), blue: Double(b), opacity: Double(a))
    }
    
    init(withHexValue hex: String) {
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
