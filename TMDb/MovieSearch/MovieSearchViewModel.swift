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
            case .success(let dictionary):
                let results = dictionary["results"] as? [[String : Any]]
                var movies = [Movie]()
                results?.forEach { movie in
                    let name = movie["title"] as? String
                    let description = movie["overview"] as? String
                    if let safeName = name, let safeDescription = description {
                        movies.append(Movie(name: safeName, desc: safeDescription))
                    }
                }
                
                self?.publish(.Success(movies: movies))
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
