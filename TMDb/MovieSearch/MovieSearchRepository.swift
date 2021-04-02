//
//  File.swift
//  TMDb
//
//  Created by Joshua Lamson on 3/22/21.
//

import Foundation

class MovieSearchRepository {
    
    static let API_KEY = "d64b05cd82a21cc483070e24b0be78ff"

    private func buildUrl(_ searchTerm: String) -> URL? {
        let safeSearch = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return URL(string: "https://api.themoviedb.org/3/search/movie" +
                    "?api_key=\(MovieSearchRepository.API_KEY)" +
                    "&language=en-US" +
                    "&include_adult=false" +
                    "&query=\(safeSearch!)")
    }
    
    func search(_ query: String, _ completion: @escaping (Result<SearchMovieResponse>) -> Void) {
        guard let url = buildUrl(query) else {
            completion(.error(SimpleError("Failed to build query URL")))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if (error != nil) {
                completion(.error(error))
                return
            }

            guard let safeData = data
            else {
                completion(.error(SimpleError("No Data or Error returned *shrug*")))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let parsedResponse = try decoder.decode(SearchMovieResponse.self, from: safeData)
                completion(.success(parsedResponse))
            } catch {
                completion(.error(error))
            }
        }
        
        task.resume()
    }
    
}
