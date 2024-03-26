//
//  UIApplication.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 13/02/2024.
//

import SwiftUI

internal extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var currentWindow: UIWindow? {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }
    
}

internal extension UIEdgeInsets {
    var swiftInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

internal extension EnvironmentValues {
    private struct SafeAreaInsetsKey: EnvironmentKey {
        static var defaultValue: EdgeInsets {
            let edgeInsets = UIApplication.shared.currentWindow?.safeAreaInsets ?? UIEdgeInsets()
            return edgeInsets.swiftInsets
        }
    }
    
    // usage @Environment(\.safeAreaInsets) private var safeAreaInsets
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}
