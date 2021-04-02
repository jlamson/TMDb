//
//  MovieSearchViewModel.swift
//  TMDb
//
//  Created by Joshua Lamson on 3/19/21.
//

import Foundation

class MovieSearchViewModel : ObservableViewModel<MovieSearchViewController, MovieSearchViewState> {
    
    private let repository: MovieSearchRepository
    
    init(repository: MovieSearchRepository) {
        self.repository = repository
    }
    
    @discardableResult
    override func observeForLifetime(
        of observer: MovieSearchViewController,
        _ closure: @escaping (MovieSearchViewController, MovieSearchViewState) -> Void
    ) -> ObservationToken {
        let token = super.observeForLifetime(of: observer, closure)
        
        publish(.Success(movies: []))
        
        return token
    }
    
    func search(query: String) {
        publish(.Loading)
        repository.search(query) { [weak self] result in
            switch (result) {
            case .success(let response):
                self?.publish(.Success(movies: response.results ?? []))
            case .error(let error):
                self?.publish(.Failure(error ?? SimpleError("Search Failed for unknown reason")))
            }
        }
    }
}

enum MovieSearchViewState {
    case Loading
    case Success(movies: [Movie])
    case Failure(_ error: Error)
}
