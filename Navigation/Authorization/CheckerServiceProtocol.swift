//
//  CheckerServiceProtocol.swift
//  Navigation
//
//  Created by m.khutornaya on 29.10.2022.
//

import Foundation

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String, completion: @escaping (Result<FirebaseAuthorization.data, NSError>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<FirebaseAuthorization.data, NSError>) -> Void)
}
