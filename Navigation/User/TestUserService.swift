//
//  TestUserService.swift
//  Navigation
//
//  Created by m.khutornaya on 26.09.2022.
//

import Foundation
import UIKit

final class TestUserService {
    private let testUser: User = User(login: "tester",
                                  password: "11111",
                                  name: "Tester",
                                  avatar: UIImage(named: "ice"),
                                  status: "Test")
}

extension TestUserService: UserServiceProtocol {
    func getUser(login: String?, password: String?) -> User? {
        guard testUser.login == login, testUser.password == password else { return nil }
        return testUser
    }
}
