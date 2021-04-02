//
//  SimpleError.swift
//  TMDb
//
//  Created by Joshua Lamson on 4/2/21.
//

import Foundation

struct SimpleError: LocalizedError {
    
    let description: String
    
    init(_ description: String) {
        self.description = description
    }
    
    var errorDescription: String? { return description}
}
