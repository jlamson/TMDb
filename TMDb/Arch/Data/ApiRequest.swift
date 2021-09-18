//
//  ApiRequest.swift
//  TMDb
//
//  Created by Joshua Lamson on 4/2/21.
//

import Foundation

struct ApiRequest {
    
}

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case head = "HEAD"
    case delete = "DELETE"
    case patch = "PATCH"
    case options = "OPTIONS"
}
