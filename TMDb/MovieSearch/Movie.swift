//
//  File.swift
//  TMDb
//
//  Created by Joshua Lamson on 3/5/21.
//

import Foundation

struct Movie {
    let name: String
    let desc: String
    
    init(name: String, desc: String) {
        self.name = name
        self.desc = desc
    }
}
