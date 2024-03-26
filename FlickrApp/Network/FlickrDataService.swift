//
//  FlickrDataService.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 10/02/2024.
//

import Foundation
import Combine

actor FlickrDataService {
    private let apiService = FlickrAPIService()
    private var currentPage = 1
    private var totalPages = 1
    
    func fetchImages(for query: String) async throws -> (String,[Photo]) {
        if currentPage > totalPages  {
            throw FlickrAPIError.noMorePagesToLoad
        }
        
        return (query ,try await fetchImagesAsync(for: query, page: currentPage))
    }

    private func fetchImagesAsync(for query: String, page: Int) async throws -> [Photo] {
        let imageData = try await apiService.searchImages(for: query, page: page)
        let photos = try JSONDecoder().decode(Photos.self, from: imageData)
        
        // Update total pages
        self.totalPages = photos.photos.pages
        self.currentPage += 1
        
        return photos.photos.photo
    }
    
    func resetValuesForNewSearch() {
        currentPage = 1
        totalPages = 1
    }
}
