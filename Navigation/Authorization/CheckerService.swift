//
//  CheckerService.swift
//  Navigation
//
//  Created by m.khutornaya on 29.10.2022.
//

import Foundation

final class CheckerService: CheckerServiceProtocol {

    public typealias data = FirebaseAuthorization.data
    public typealias auth = FirebaseAuthorization.auth
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<data, NSError>) -> Void) {
        auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil,
                  let result = result else {
                completion(.failure(error! as NSError))
                return
            }

            completion(.success(result))
        }
    }

    func signUp(email: String, password: String, completion: @escaping (Result<data, NSError>) -> Void) {
        auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil,
                  let result = result else {
                completion(.failure(error! as NSError))
                return
            }

            completion(.success(result))
        }
    }

    func isCurrentUser() -> Bool {
        guard let _ = auth.auth().currentUser else {
            return false
        }
        return true
    }
}
