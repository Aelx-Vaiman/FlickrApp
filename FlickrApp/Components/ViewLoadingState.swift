//
//  File.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 16/02/2024.
//

import Foundation

enum ViewLoadingState {
    case empty
    case loading
    case loaded
    case error(error: Error)
}
