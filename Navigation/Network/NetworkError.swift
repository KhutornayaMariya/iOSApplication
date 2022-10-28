//
//  NetworkError.swift
//  Navigation
//
//  Created by m.khutornaya on 28.10.2022.
//

import Foundation

enum NetworkError: Error {
    case `default`
    case serverError
    case parseError(reason: String)
    case unknownError
}
