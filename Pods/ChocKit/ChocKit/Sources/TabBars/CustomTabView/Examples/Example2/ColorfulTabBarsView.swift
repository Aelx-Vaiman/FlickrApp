//
//  CustomTabView.swift
//  Vardiac
//
//  Created by Alex Vaiman on 06/03/2024.
//

import SwiftUI

struct ColorfulTabBarsView: View {
    
    private let tabs: [ColorfulTabBarItem] = ColorfulTabBarItem.allCases
    @Binding var selection: ColorfulTabBarItem
    @Namespace private var namespace
    @State private var localSelection: ColorfulTabBarItem
    
    init(selection: Binding<ColorfulTabBarItem>) {
        self.localSelection = selection.wrappedValue
        self._selection = selection
        
    }
    
    var body: some View {
        tabBar
            .onChange(of: selection, perform: { value in
                withAnimation(.easeInOut) {
                    localSelection = value
                }
            })
            .background(.red.opacity(0))
    }
}


extension ColorfulTabBarsView {
    
    private func tabView(tab: ColorfulTabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == tab  ?  tab.color : Color.gray)
        
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0))
                }
            }
                .contentShape(RoundedRectangle(cornerRadius: 10))
        )
        .onTapGesture {
            switchToTab(tab: tab)
        }
    }
    
    private var tabBar: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding([.horizontal, .top])
    }
    
    private func switchToTab(tab: ColorfulTabBarItem) {
        selection = tab
    }
    
}



struct CustomTabBarView_Previews: PreviewProvider {
    
    static let selection: ColorfulTabBarItem = .home
    
    static var previews: some View {
        VStack {
            Spacer()
            ColorfulTabBarsView(selection: .constant(selection))
        }
    }
}
