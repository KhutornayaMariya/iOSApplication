//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by m.khutornaya on 03.12.2022.
//

import Foundation
import LocalAuthentication

final class LocalAuthorizationService {

    private let laContext = LAContext()

    private var error: NSError?

    lazy var isBiometricAuthEnabled: Bool = {
        laContext.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        )
    }()

    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        laContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Авторизируйтесь для доступа в аккаунт"
        ) { success, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Try another method, \(error.localizedDescription)")
                    authorizationFinished(false)
                }

                authorizationFinished(true)
            }
        }
    }
}
