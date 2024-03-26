//
//  ZoomableWebImageView.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 10/02/2024.
//

import ChocKit
import SwiftUI
import Kingfisher

struct ZoomableWebImageView: View {
    let url: URL?
    
    @GestureState private var magnifyBy: CGFloat = 1.0 // Track the scale factor
    @State private var offset: CGSize = .zero // Track the offset for dragging
    @State private var lastOffset: CGSize = .zero // Track the last offset for dragging
    @State private var lastScale: CGFloat = 1.0 // Track the last scale for zooming
    @State private var viewState: ViewLoadingState = .loading // Track the loading state
    let backgroundColor: Color
    
    init(url: URL?, backgroundColor: Color) {
        self.url = url
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        ZStack (alignment: .center) {
            // best place for background setting in ZStack
            backgroundColor
                .ignoresSafeArea()
                .gesture(
                    TapGesture(count: 2)
                        .onEnded {
                            resetImageScaleAndPosition()
                        }
                )
            
            KFImage(url)
                .onSuccess { _ in
                    viewState = .loaded // Image loading succeeded, hide the indicator
                }
                .onFailure { error in
                    viewState = .error(error: error) // Image loading failed, hide the indicator
                }
                .resizable()
                .padding(.horizontal, 24)
                .scaledToFit()
                .scaleEffect(magnifyBy * lastScale)
                .offset(offset)
                .gesture(
                    MagnificationGesture()
                        .updating($magnifyBy) { value, state, _ in
                            state = value
                        }
                        .onEnded { value in
                            lastScale *= value
                        }
                        .simultaneously(with: DragGesture()
                            .onChanged { value in
                                offset.width = lastOffset.width + value.translation.width
                                offset.height = lastOffset.height + value.translation.height
                            }
                            .onEnded { value in
                                lastOffset = offset
                            }
                        )
                )
            
                .gesture(
                    TapGesture(count: 2)
                        .onEnded {
                            resetImageScaleAndPosition()
                        }
                )
            
            if case .loading = viewState {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                    .scaleEffect(2.0)
                    .padding()
            } else if case .error = viewState {
                ErrorView("Error failed fetching the Image", systemImage: "exclamationmark.triangle").foregroundStyle(.red, .red)
            }
        }
    }
    
    private func resetImageScaleAndPosition() {
        lastScale = 1.0
        offset = .zero
        lastOffset = .zero
    }
}

struct FullScreenView_Previews: PreviewProvider {
    static let url = URL(string: "https://prod-ripcut-delivery.disney-plus.net/v1/variant/disney/10DD78F3923D15405A2FF55695659232A4464FF383DC1C4CF4B2D1C4E58CE0F5/scale?width=1200&amp;aspectRatio=1.78&amp;format=webp")
    
    static let badURL: URL? = nil
    
    static var previews: some View {
        Group {
            ZoomableWebImageView(url: url, backgroundColor: Color.theme.background)
            ZoomableWebImageView(url: badURL, backgroundColor: Color.theme.background)
        }
    }
}
