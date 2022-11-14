//
//  PlanetModel.swift
//  Navigation
//
//  Created by m.khutornaya on 28.10.2022.
//

import Foundation

struct PlanetModel: Decodable {
    let orbitalPeriod: String
    let residents: [String]
}
