//
//  MovieSearchViewModel.swift
//  TMDb
//
//  Created by Joshua Lamson on 3/19/21.
//

import Foundation

class MovieSearchViewModel : ObservableViewModel<MovieSearchViewController, MovieSearchViewState> {
    
    let movieData: [Movie] = {
        var movies: [Movie] = []
        for i in 1...10 {
            movies.append(
                Movie(name: "name" + "\(i)",
                      desc: "\(i)" + ": Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dignissim enim sit amet venenatis urna. Sit amet luctus venenatis lectus magna fringilla urna porttitor.")
            )
        }
        return movies
    }()
    
    @discardableResult
    override func observeForLifetime(
        of observer: MovieSearchViewController,
        _ closure: @escaping (MovieSearchViewController, MovieSearchViewState) -> Void
    ) -> ObservationToken {
        let token = super.observeForLifetime(of: observer, closure)
        
        publish(.Loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.publish(.Success(movies: self.movieData))
        }
        
        return token
    }
    
}

enum MovieSearchViewState {
    case Loading
    case Success(movies: [Movie])
    case Failure(error: Error)
}
