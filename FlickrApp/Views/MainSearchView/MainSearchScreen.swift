//
//  MainSearchScreen.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 10/02/2024.
//

import ChocKit
import Foundation
import Kingfisher
import SwiftUI

struct MainSearchScreen: View {
    @StateObject private var viewModel = MainSearchScreenModel(backgroundColor: Color.theme.background)

    var body: some View {
        ZStack {
            // best place for background setting in ZStack
            viewModel.backgroundColor.opacity(viewModel.showPicker ? 0.5 : 1)
                .ignoresSafeArea()
            
            VStack{
                SearchView(viewModel: viewModel)
                    .padding([.leading, .trailing, .bottom, .top], 8)
                
                ScrollView {
                    photosContent
                }
            
                
                // Using transparent Divider for infinite scroll respecting bottom safe area. Remove if not needed.
               // Divider().opacity(0)
            } // VStack
            
            statesView
                .padding(.bottom, 8)
            
            if viewModel.showPicker { // Show the picker if showPicker is true
                PickerView(viewModel: viewModel)
            }
            
        }
    }
}

fileprivate extension MainSearchScreen {
    var  photosContent: some View {
        LazyVGrid(columns:Array(repeating: GridItem(.flexible()), count: viewModel.cellsPerRow), spacing: 6) {
            ForEach(viewModel.photos.indices, id: \.self) { index in
                let photo = viewModel.photos[index]
                NavigationLink(value:  photo.getImagePath("b")) {
                    KFImage(photo.getImagePath())
                        .reducePriorityOnDisappear(true)
                        .startLoadingBeforeViewAppear(true)
                        .placeholder {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                        }
                        .onFailureImage(UIImage(named: "placeHolder"))
                        .resizable()
                        .aspectRatio(CGSize(width: imageSize(), height: imageSize()), contentMode: .fit)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .onAppear {
                            viewModel.loadMoreIfNeeded(currentIndex: index)
                        }
                }
            }
        }
        .navigationDestination(for: URL.self, destination: { url in
            ZoomableWebImageView(url: url, backgroundColor: viewModel.backgroundColor)
        })
        .padding(.horizontal,6)
    }
    
    private func imageSize() -> CGFloat {
        let width = UIScreen.main.bounds.size.width//size.width
        let availableWidth = width -  (CGFloat(viewModel.cellsPerRow + 1) * 6) // subtract padding.
        return availableWidth / CGFloat(viewModel.cellsPerRow)
    }
}

fileprivate extension MainSearchScreen {
    var  statesView: some View {
        VStack {
            Spacer()
            
            switch viewModel.viewState {
            case .empty:
                Text(FlickrAPIError.noImagesFound.localizedDescription)
                    .foregroundStyle(.accent)
            case .loaded:
                if viewModel.photos.isEmpty {
                    Text(FlickrAPIError.noImagesFound.localizedDescription)
                        .foregroundStyle(.accent)
                }
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .red)) // Make the progress indicator red
                    .scaleEffect(2.0) // Make the progress indicator larger
                    .padding() // Add padding around the progress indicator
            case .error(let error):
                if let networkError = error as? FlickrAPIError, networkError == .noMorePagesToLoad || networkError == .taskCancelled {
                    // we ignore this errors
                } else if let networkError = error as? FlickrAPIError, networkError == .noInternetConnection {
                    if viewModel.photos.isEmpty {
                        ErrorView(FlickrAPIError.noInternetConnection.localizedDescription, systemImage: "wifi.exclamationmark").foregroundStyle(.accent)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // for placing in center
                    } else {
                        Text(FlickrAPIError.failedFetchingImages.localizedDescription)
                            .foregroundStyle(.white)
                            .padding(4)
                            .background(.black.opacity(0.6))
                            .cornerRadius(20)
                        
                    }
                } else {
                    Text(FlickrAPIError.failedFetchingImages.localizedDescription)
                        .foregroundStyle(.white)
                        .padding(4)
                        .background(.black.opacity(0.6))
                        .cornerRadius(20)
                    
                }
            }
        }
    }
}

struct SMainSearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainSearchScreen()
    }
}
