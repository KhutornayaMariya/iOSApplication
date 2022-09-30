//
//  Checker.swift
//  Navigation
//
//  Created by m.khutornaya on 28.09.2022.
//

class Checker {

    static let shared: Checker = Checker()

    private let login: String = "happyCat"
    private let password: String = "12345"

    private init() {}

    func check(login: String, password: String) -> Bool {
        guard login == self.login,
              password == self.password else {
            return false
        }
        return true
    }
}
