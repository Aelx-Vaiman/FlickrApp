//
//  TabBarDefaultView.swift
//  Catalog
//
//  Created by Nick Sarno on 11/14/21.
//

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

public struct DefaultBarView: View {
    
    private let tabs: [DefaultBarItem]
    @Binding private var selection: DefaultBarItem
    private let accentColor: Color
    private let defaultColor: Color
    private let backgroundColor: Color?
    private let font: Font
    private let iconSize: CGFloat
    private let spacing: CGFloat
    private let insetPadding: CGFloat
    private let outerPadding: CGFloat
    private let cornerRadius: CGFloat
    private let shadow: ChockShadow
    
    var outerBackgroundColor: Color {
        backgroundColor ?? .clear
    }
    
    public init(
        tabs: [DefaultBarItem],
        selection: Binding<DefaultBarItem>,
        accentColor: Color = .blue,
        defaultColor: Color = .gray,
        backgroundColor: Color? = nil,
        font: Font = .subheadline,
        iconSize: CGFloat = 20,
        spacing: CGFloat = 6,
        insetPadding: CGFloat = 16,
        outerPadding: CGFloat = 0,
        cornerRadius: CGFloat = 0,
        shadow: ChockShadow = ChockShadow(radius: 0)
    ) {
        self._selection = selection
        self.tabs = tabs
        self.accentColor = accentColor
        self.defaultColor = defaultColor
        self.backgroundColor = backgroundColor
        self.font = font
        self.iconSize = iconSize
        self.spacing = spacing
        self.insetPadding = insetPadding
        self.outerPadding = outerPadding
        self.cornerRadius = cornerRadius
        self.shadow = shadow
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(.horizontal, insetPadding)
        .background(
            ZStack {
                if let backgroundColor = backgroundColor {
                    backgroundColor
                        .cornerRadius(cornerRadius)
                        .shadow(
                            color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y
                        )
                } else {
                    Color.clear
                }
            }
        )
        .padding(outerPadding)
        .background(
            outerBackgroundColor
        )
    }

    private func switchToTab(tab: DefaultBarItem) {
        selection = tab
    }
    
}

private extension DefaultBarView {
    
    private func tabView(_ tab: DefaultBarItem) -> some View {
        VStack(spacing: spacing) {
            tab.image
                .resizable()
                .scaledToFit()
                .frame(width: iconSize, height: iconSize)
            
            Text(tab.title)
        }
        .font(font)
        .foregroundColor(selection.hashValue == tab.hashValue  ? accentColor : defaultColor)
        .frame(maxWidth: .infinity)
        .padding(.vertical, insetPadding)
        .overlay(
            ZStack {
                if let count = tab.currentBadgeCount, count > 0 {
                    Text("\(count)")
                        .foregroundColor(.white)
                        .font(.caption)
                        .padding(6)
                        .background(accentColor)
                        .clipShape(Circle())
                        .offset(x: iconSize * 0.9, y: -iconSize * 0.9)
                }
            }
        )
    }
    
}

struct TabBarDefaultView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultTabBar()
    }
}
