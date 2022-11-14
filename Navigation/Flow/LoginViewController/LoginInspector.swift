//
//  LoginInspector.swift
//  Navigation
//
//  Created by m.khutornaya on 28.09.2022.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {

    typealias data = FirebaseAuthorization.data

    private let checkerService: CheckerServiceProtocol = CheckerService()

    func checkCredentials(email: String, password: String, completion: @escaping (Result<data, NSError>) -> Void) {
        checkerService.checkCredentials(email: email, password: password, completion: completion)
    }

    func signUp(email: String, password: String, completion: @escaping (Result<data, NSError>) -> Void) {
        checkerService.signUp(email: email, password: password, completion: completion)
    }

    func isCurrentUser() -> Bool {
        checkerService.isCurrentUser()
    }
}
