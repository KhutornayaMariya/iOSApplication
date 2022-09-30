//
//  LoginInspector.swift
//  Navigation
//
//  Created by m.khutornaya on 28.09.2022.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)
    }
}
