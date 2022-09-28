//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by m.khutornaya on 28.09.2022.
//

import Foundation

protocol LoginFactoryProtocol {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactoryProtocol {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
