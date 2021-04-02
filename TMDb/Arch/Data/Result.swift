//
//  Result.swift
//  TMDb
//
//  Created by Joshua Lamson on 4/2/21.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case error(Error?)
}
