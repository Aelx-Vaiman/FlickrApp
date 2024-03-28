//
//  MainSearchScreenModel.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 10/02/2024.
//

import SwiftUI
import Foundation
import Combine
import Kingfisher

@MainActor
class MainSearchScreenModel: ObservableObject {
    let backgroundColor: Color
    private let isiOSAppOnMac = ProcessInfo.processInfo.isiOSAppOnMac
    private let flickrDataService: FlickrDataService
    let maxNumberOfChoices = ProcessInfo.processInfo.isiOSAppOnMac ? 6 : 4
    
    @Published private(set) var photos: [Photo] = []
    @Published private(set) var viewState: ViewLoadingState = .empty
    @Published var cellsPerRow = ProcessInfo.processInfo.isiOSAppOnMac ? 6 : 3
    @Published var searchText = ""
    @Published var showPicker = false
    
    private var searchQuery = ""
    private var fetchMoreInProgress = false
    
    private var cancellable = Set<AnyCancellable>()
    private var newSearchTask: Task<(), Never>?
    private var fetchMoreTask: Task<(), Never>?
    
    init( backgroundColor: Color, flickrDataService: FlickrDataService = FlickrDataService() ) {
        self.backgroundColor = backgroundColor
        self.flickrDataService = flickrDataService
        setupSearchTextPublisher()
        ImageCache.default.memoryStorage.config.countLimit = 500
    }
    
    private func setupSearchTextPublisher() {
        $searchText
            .debounce(for: .milliseconds(1000), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newSearchText in
                self?.searchQueryChanged(newSearchText)
            }
            .store(in: &cancellable)
    }

    private func searchQueryChanged(_ newSearchText: String) {
        guard !newSearchText.isEmpty else {
            return
        }
        
        searchQuery = newSearchText
        newSearchTask?.cancel()
        fetchMoreTask?.cancel()
      
        newSearchTask = Task {
            await resetValuesForNewSearch()
            await fetchNextImages()
        }
    }
    
    func loadMoreIfNeeded(currentIndex: Int) {
        let thresholdPhotos = isiOSAppOnMac ? 100 : 40
        guard fetchMoreInProgress == false, currentIndex + thresholdPhotos >= photos.count else {
            return
        }
        
        fetchMoreInProgress = true
        fetchMoreTask = Task {
            await fetchNextImages()
            fetchMoreInProgress = false
        }
    }
    
    func fetchNextImages() async {
        viewState = .loading
        
        do {
            let (query ,fetchedPhotos) = try await flickrDataService.fetchImages(for: searchQuery)
            // If Irrelevant data fetched, don't change the viewState to .loaded
            if query == searchQuery {
                photos.append(contentsOf: fetchedPhotos)
                viewState = .loaded
            }
        } catch URLError.cancelled  {
            viewState = .error(error: FlickrAPIError.taskCancelled)
        } catch let err {
            viewState = .error(error: err)
        }
    }

    
    private func resetValuesForNewSearch() async {
        photos = []
        ImageCache.default.clearMemoryCache()
        viewState = .empty
        await flickrDataService.resetValuesForNewSearch()
    }
    
}
