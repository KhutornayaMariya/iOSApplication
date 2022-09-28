//
//  CurrentUserService.swift
//  Navigation
//
//  Created by m.khutornaya on 26.09.2022.
//

import Foundation
import UIKit

final class CurrentUserService {
    private let user: User = User(login: "happyCat",
                                  password: "12345",
                                  name: "Hipster Cat",
                                  avatar: UIImage(named: "ice"),
                                  status: "Myow")
}

extension CurrentUserService: UserServiceProtocol {
    func getUser(login: String?, password: String?) -> User? {
        guard user.login == login, user.password == password else { return nil }
        return user
    }
}
