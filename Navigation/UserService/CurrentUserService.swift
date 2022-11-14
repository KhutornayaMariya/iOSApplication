//
//  CurrentUserService.swift
//  Navigation
//
//  Created by m.khutornaya on 26.09.2022.
//

import UIKit

final class CurrentUserService {
    private let user: UserModel = UserModel(name: "Hipster Cat", avatar: UIImage(named: "ice"), status: "Myow")
}

extension CurrentUserService: UserServiceProtocol {
    func getUser() -> UserModel {
        return user
    }
}
