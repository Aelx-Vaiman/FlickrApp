//
//  DefaultSkinTab.swift
//  Playground
//
//  Created by Alex Vaiman on 09/03/2024.
//

import Foundation
import SwiftUI

/// Customizable TabBar
///
///  ```swift
///  // 'Default' style
///  BarDefaultView(
///     tabs: tabs,
///     selection: $selection,
///     accentColor: .blue,
///     defaultColor: .gray,
///     backgroundColor: .white,
///     font: .subheadline,
///     iconSize: 20,
///     spacing: 6,
///     insetPadding: 16,
///     outerPadding: 0
///     )
///
///  // 'Floating' style
///  BarDefaultView(
///     tabs: tabs,
///     selection: $selection,
///     accentColor: .blue,
///     defaultColor: .gray,
///     backgroundColor: .white,
///     font: .subheadline,
///     iconSize: 20,
///     spacing: 6,
///     insetPadding: 12,
///     outerPadding: 12,
///     cornerRadius: 30,
///     shadow: ChockShadow(radius: 8, y:  -5) 
///     )
///  ```

struct DefaultTabBar: View {
    
    private static let tabs: [DefaultBarItem] = [
        DefaultBarItem(title: "Home", systemName: "heart.fill", badgeCount: 2),
        DefaultBarItem(title: "Browse", systemName: "magnifyingglass"),
        DefaultBarItem(title: "Discover", systemName: "globe", badgeCount: 100),
        DefaultBarItem(title: "Profile", systemName: "person.fill")
    ]
    
    
    @State var selectedTab = DefaultTabBar.tabs[0]
    @State var tabItems = DefaultTabBar.tabs
    
    var tabsView: some View {
        DefaultBarView(
            tabs: tabItems,
            selection: $selectedTab,
            accentColor: .red,
            defaultColor: .white,
            backgroundColor: .indigo,
            font: .subheadline,
            iconSize: 20,
            spacing: 6,
            insetPadding: 12,
            outerPadding: 12,
            cornerRadius: 30,
            shadow: ChockShadow(radius: 8, color: .black, y:  5))
    }
    
    var body: some View {
        CustomTabView(tabBarView: tabsView, tabs: tabItems, selection: selectedTab) {
            NavigationView {
                ZStack {
                    Color.yellow
                    VStack {
                        Text("Home")
                            .navigationBarTitle("Home")
                    }
                }
            }.onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    let current = tabItems[0].currentBadgeCount ?? 0
                    tabItems[0].updateBadgeCount(to: current + 1)
                }
            }
            
            NavigationView {
                ZStack {
                    Color.blue
                    VStack {
                        Text("Brows")
                            .navigationBarTitle("Brows")
                    }
                }
            }
            
            NavigationView {
                ZStack {
                    Color.green
                    VStack {
                        Text("Discover")
                            .navigationBarTitle("Discover")
                    }
                }
            }
            
            NavigationView {
                ZStack {
                    Color.orange.ignoresSafeArea()
                    VStack {
                        Text("Profile")
                            .navigationBarTitle("Profile")
                    }
                }
            }
    
        }
    }
}

struct DefaultTabBar_Previews: PreviewProvider {
    static var previews: some View {
        DefaultTabBar()
    }
}

