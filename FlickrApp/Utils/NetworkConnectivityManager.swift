//
//  NetworkConnectivityManager.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 27/02/2024.
//

import Foundation
import Network

// The pathUpdateHandler does not work properly in an iOS simulator but works as expected on a real device.
final class NetworkConnectivityManager: Sendable {

    static let shared = NetworkConnectivityManager()
    static let networkConnectivityDidChangeNotificationName = Notification.Name(rawValue: "networkConnectivityManagerDidChangeNotification")

    let pathMonitor = NWPathMonitor()
    let monitoringQueue = DispatchQueue(label: "networkConnectivityManager.com_\(UUID().uuidString)", qos: .utility)

    private init() {
        pathMonitor.pathUpdateHandler = { path in
            NotificationCenter.default.post(name: Self.networkConnectivityDidChangeNotificationName, object: path.status)
        }
        pathMonitor.start(queue: monitoringQueue)
    }

    deinit {
        pathMonitor.cancel()
    }
    
    var isNetworkAvailable: Bool {
#if targetEnvironment(simulator)
        return true
#else
        return pathMonitor.currentPath.status == .satisfied
#endif
    }

}
