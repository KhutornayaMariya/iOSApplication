//
//  TestUserService.swift
//  Navigation
//
//  Created by m.khutornaya on 26.09.2022.
//

import UIKit

final class TestUserService {
    private let testUser: UserModel = UserModel(name: "Tester", avatar: UIImage(named: "ice"), status: "Test")
}

extension TestUserService: UserServiceProtocol {
    func getUser() -> UserModel {
        return testUser
    }
}
