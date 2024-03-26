//
//  TabBarItem.swift
//  
//
//  Created by Nick Sarno on 4/8/22.
//

import Foundation
import SwiftUI

public struct DefaultBarItem:  Hashable {
    public let title: String
    public let image: Image
    
    private var badgeCount: Int?
    // used for hash.
    private let resourceName: String
    
    public var currentBadgeCount: Int? {
        badgeCount 
    }
    
    // tagID must be unique string, each tub must have different
    //*** important!! same!! tag should be given to the screen witch belongs to the tab, doing so by calling .chockBarItem(tagID)
    public init(title: String, resource: String, badgeCount: Int? = nil) {
        self.resourceName = resource
        self.title = title
        self.image = Image(resource)
        self.badgeCount = badgeCount
    }

    
    public init(title: String, systemName: String = "", badgeCount: Int? = nil) {
        self.resourceName = systemName
        self.title = title
        self.image = Image(systemName: systemName)
        self.badgeCount = badgeCount
    }
    
    public mutating func updateBadgeCount(to count: Int) {
        badgeCount = count
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(resourceName)
      //  hasher.combine(badgeCount)
    }
}
