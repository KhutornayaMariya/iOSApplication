//
//  AppConfiguration.swift
//  Navigation
//
//  Created by m.khutornaya on 27.10.2022.
//

import Foundation

enum AppConfiguration {
    case people
    case starships
    case planets

    var url: URL? {
        switch self {
        case .people:
            return URL(string: "https://swapi.dev/api/people/8")
        case .planets:
            return URL(string: "https://swapi.dev/api/planets/5")
        case .starships:
            return URL(string: "https://swapi.dev/api/starships/3")
        }
    }
}
