//
//  UIApplication.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 13/02/2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    
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
    
   var edgeInsets: EdgeInsets {
        let edgeInsets = currentWindow?.safeAreaInsets ?? UIEdgeInsets()
        return edgeInsets.swiftInsets
    }
    
}

extension UIEdgeInsets {
    var swiftInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
