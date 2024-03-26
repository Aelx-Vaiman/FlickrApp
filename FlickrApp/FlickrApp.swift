//
//  FlickrApp.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 10/02/2024.
//

import SwiftUI

@main
struct FlickrApp: App {
    
    init() {
        _ = NetworkConnectivityManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
        }
    }
}
