//
//  Coordinator.swift
//  TMDb
//
//  Created by Joshua Lamson on 3/19/21.
//

import UIKit

protocol Coordinator: class {
    func start(with args: Dictionary<String, Any>?)
    func viewController() -> UIViewController
}
