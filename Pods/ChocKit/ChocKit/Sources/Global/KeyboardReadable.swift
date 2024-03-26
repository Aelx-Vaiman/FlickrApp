//
//  KeyboardReadable.swift
//  ChocKit
//
//  Created by Alex Vaiman on 05/03/2024.
//

import Combine
import UIKit

/// Publisher to read keyboard changes
@available(iOS 13.0, *)
public protocol KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
}

@available(iOS 13.0, *)
public extension KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
}
