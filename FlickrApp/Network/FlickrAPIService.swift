//
//  FlickrAPIService.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 10/02/2024.
//


import Foundation
import Combine
import Network

protocol FlickrAPIProtocol: Sendable {
    func searchImages(for query: String, page: Int) async throws -> Data
}

final class FlickrAPIService: FlickrAPIProtocol {
    private let flickrKey = "a6701da737ccc259fe77fc3ee4839cdd"
    private let baseURL = "https://www.flickr.com/services/rest/"
    private let perPageCount = ProcessInfo.processInfo.isiOSAppOnMac ? 100 : 40
    
    func searchImages(for query: String, page: Int) async throws -> Data {
        // The pathUpdateHandler does not work properly in an iOS simulator but works as expected on a real device.
        guard NetworkConnectivityManager.shared.isNetworkAvailable else {
            throw FlickrAPIError.noInternetConnection
        }
        
        guard let url = buildURL(query: query, page: page) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (X11; Linux x86_64; rv:10.0) Gecko/20100101 Firefox/10.0", forHTTPHeaderField: "User-Agent")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            let body = String(data: data, encoding: .utf8)
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw URLError(URLError.Code(rawValue: statusCode) , userInfo: ["err description": body ?? "none"])
        }
        
        return data
    }
    
    private func buildURL(query: String, page: Int) -> URL? {
        let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)?method=flickr.photos.search&api_key=\(flickrKey)&text=\(escapedQuery)&per_page=\(perPageCount)&page=\(page)&safe_search=3&format=json&nojsoncallback=1"
        return URL(string: urlString)
    }
}

enum FlickrAPIError: Error, LocalizedError {
    case taskCancelled
    case noInternetConnection
    case noMorePagesToLoad
    case noImagesFound
    case failedFetchingImages
    
    var errorDescription: String? {
        switch self {
        
        case .taskCancelled:
            return "task cancelled..."
        case .noInternetConnection:
            return "No internet connection. Please check your network settings and try again."
        case .noMorePagesToLoad:
            return "no more pages to load..."
        case .noImagesFound:
            return  "No images found"
        case .failedFetchingImages:
            return "Failed fetching images..."
        }
    }
}
