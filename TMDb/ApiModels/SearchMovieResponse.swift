//
//  SearchMovieResponse.swift
//  TMDb
//
//  Created by Joshua Lamson on 4/2/21.
//

import Foundation

struct SearchMovieResponse: Decodable {
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: [Movie]?
}
