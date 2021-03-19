//
//  NavGraph.swift
//  TMDb
//
//  Created by Joshua Lamson on 3/19/21.
//

import Foundation
import UIKit

protocol INavGraph: class {
    var rootController: UINavigationController { get }
    func push(to destination: Destination)
    func pop()
}

protocol DestinationFactory : class {
    func getView(for destination: Destination) -> UIViewController
}

class NavGraph : INavGraph {
    
    // MARK: - Properties

    private(set) var rootController: UINavigationController
    
    weak var destinationFactory: DestinationFactory?
    
    // MARK: - Initialization

    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
    
    // MARK: - Public
    
    func push(to destination: Destination) {
        let destinationViewController = destinationFactory!.getView(for: destination)
        
        rootController.title = name(for: destination)
        rootController.pushViewController(destinationViewController, animated: true)
    }

    func pop() {
        rootController.popViewController(animated: true)
    }
    
    // MARK: - Names
    
    func name(for destination: Destination) -> String {
        switch(destination) {
        case .search:
            return "Search"
        }
    }
}

enum Destination {
    case search
}
