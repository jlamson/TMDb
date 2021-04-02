//
//  SearchMovieCoordinator.swift
//  TMDb
//
//  Created by Joshua Lamson on 3/19/21.
//

import Foundation
import UIKit

class MovieSearchCoordinator: Coordinator {
    
    var movieSearchViewController: MovieSearchViewController

    init(_ navGraph: INavGraph, _ remoteImageResolver: RemoteImageResolver) {
        movieSearchViewController = MovieSearchViewController()
        movieSearchViewController.remoteImageResolver = remoteImageResolver

        movieSearchViewController.viewModel = MovieSearchViewModel(
            repository: MovieSearchRepository()
        )
    }
    
    func start(with args: Dictionary<String, Any>? = nil) {
        // nothing needed yet
    }
    
    func viewController() -> UIViewController {
        return movieSearchViewController
    }
}
