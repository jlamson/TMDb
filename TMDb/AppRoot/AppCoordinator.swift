//
//  AppCoordinator.swift
//  TMDb
//
//  Created by Joshua Lamson on 3/19/21.
//

import Foundation
import UIKit

class AppCoordinator: NSObject, Coordinator {
    
    let window: UIWindow
    let navGraph: NavGraph
    
    private var childCoordinators = [Destination : Coordinator]()
    private let remoteImageResolver: RemoteImageResolver = {
        let cache = NSCache<AnyObject, AnyObject>()
        // Customize Cache?
        return CachedRemoteImageResolver(cache: cache)
    }()
    
    init(window: UIWindow) {
        self.window = window
        self.navGraph = NavGraph(rootController: UINavigationController())
    }
    
    func start(with args: Dictionary<String, Any>? = nil) {
        window.rootViewController = navGraph.rootController
        window.makeKeyAndVisible()

        navGraph.destinationFactory = self
        navGraph.push(to: .search)
    }
    
    func viewController() -> UIViewController {
        return navGraph.rootController
    }
}

extension AppCoordinator : DestinationFactory {

    func getView(for destination: Destination) -> UIViewController {
        switch destination {
        case .search:
            var searchCoordinator = childCoordinators[.search]
            if (searchCoordinator == nil) {
                searchCoordinator = MovieSearchCoordinator(navGraph, remoteImageResolver)
                childCoordinators[.search] = searchCoordinator
            }
            return searchCoordinator!.viewController()
        }
    }
}
