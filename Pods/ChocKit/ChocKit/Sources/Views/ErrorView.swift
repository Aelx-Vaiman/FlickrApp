//
//  ErrorView.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 18/02/2024.
//

/*
 This is my error view. For iOS 17 and later, it's recommended to use ContentUnavailableView. However, this view can still be utilized to support older versions.
 */

import SwiftUI

public struct ErrorView<ContentLabel, Description, Actions> : View where ContentLabel : View, Description : View, Actions : View {
    
    private let label: ContentLabel
    private let description: Description
    private let action: Actions
    
    public init(@ViewBuilder label: () -> ContentLabel, @ViewBuilder description: () -> Description = { EmptyView() },  @ViewBuilder action: () -> Actions = { EmptyView() }) {
        self.label = label()
        self.description = description()
        self.action = action()
    }
    
    public var body: some View {
        VStack(spacing: 4) {
            label
                .labelStyle(ErrorLabelStyle())
                //.labelStyle(.titleOnly)
                .font(Font.title2.weight(.semibold))
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
            
            description
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(4)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
            
            action
            
        }
        .padding(48)
    }
}

public extension ErrorView where ContentLabel == Label<Text, Image>, Description == Text?, Actions == EmptyView {
    
    init(_ title: LocalizedStringKey, systemImage name: String, description: Text? = nil) {
        self.init {
            Label(title, systemImage: name)
        } description: {
            description
        }
    }
    
    init<S>(_ title: S, systemImage name: String, description: Text? = nil) where S : StringProtocol {
        self.init {
            Label(title, systemImage: name)
        } description: {
            description
        }
    }
    
    init(_ title: LocalizedStringKey, image name: String, description: Text? = nil) {
        self.init {
            Label(title, image: name)
        } description: {
            description
        }
    }
    
    init<S>(_ title: S, image name: String, description: Text? = nil) where S : StringProtocol {
        self.init {
            Label(title, image: name)
        } description: {
            description
        }
    }
}

private struct ErrorLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 10) {
            configuration.icon
                .font(.system(size: 120).weight(.light))
                .foregroundStyle(.secondary)
            
            configuration.title
        }
    }
}

public struct ErrorView_Previews: PreviewProvider {
    public static var previews: some View {
            ErrorView {
                Label("No internet connection. Please check your network settings and try again.", systemImage: "wifi.exclamationmark")
            } description: {
                Text("maybe in the next life")
            }
    }
}
