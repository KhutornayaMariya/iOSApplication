//
//  LoginInspector.swift
//  Navigation
//
//  Created by m.khutornaya on 28.09.2022.
//

import Foundation
import FirebaseAuth

class LoginInspector: LoginViewControllerDelegate {

    private let checkerService: CheckerServiceProtocol = CheckerService()

    func checkCredentials(email: String, password: String, completion: @escaping (Result<AuthDataResult, NSError>) -> Void) {
        checkerService.checkCredentials(email: email, password: password, completion: completion)
    }

    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, NSError>) -> Void) {
        checkerService.signUp(email: email, password: password, completion: completion)
    }
}
