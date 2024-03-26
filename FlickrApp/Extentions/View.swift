//
//  File.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 13/02/2024.
//

import SwiftUI

extension View {
    func withTextOverlay(_ text: String, font: Font = .caption) -> some View {
        self
            .overlay(
                VStack {
                    Spacer()
                    Text(text)
                        .font(font)
                        .padding(6)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10.0)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5) 
                        //.multilineTextAlignment(.leading)
                }
            , alignment: .bottom
        )
    }
}
