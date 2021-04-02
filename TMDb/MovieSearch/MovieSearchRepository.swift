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
    
    func search(_ query: String, _ completion: @escaping (Result<[String : Any]>) -> Void) {
        guard let url = buildUrl(query) else {
            completion(.error(SimpleError("Failed to build query URL")))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if (error != nil) {
                completion(.error(error))
                return
            }

            guard data != nil else {
                completion(.error(SimpleError("No Data or Error returned *shrug*")))
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: []) else {
                completion(.error(SimpleError("Couldn't parse response as JSON *shrug*")))
                return
            }
            
            guard let dictionary = json as? [String : Any] else {
                completion(.error(SimpleError("Couldn't parse response as [String : Any] *shrug*")))
                return
            }
            
            completion(.success(dictionary))
        }
        
        task.resume()
    }
    
}
