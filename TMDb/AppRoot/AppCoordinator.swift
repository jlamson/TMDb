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
    
    private var childCoordinators = Dictionary<Destination, Coordinator>()
    
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
                searchCoordinator = MovieSearchCoordinator(navGraph)
                childCoordinators[.search] = searchCoordinator
            }
            return searchCoordinator!.viewController()
        }
    }
}
