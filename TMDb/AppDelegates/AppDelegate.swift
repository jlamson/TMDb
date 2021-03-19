//
//  AppDelegate.swift
//  TMDb
//
//  Created by Joshua Lamson on 2/19/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        start()
        
        return true
    }
}

extension AppDelegate {

    /// Start the app
    private func start() {
        guard let window = window else {
            fatalError("Window could not be resolved")
        }

        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
    }
}
