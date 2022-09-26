//
//  User.swift
//  Navigation
//
//  Created by m.khutornaya on 26.09.2022.
//

import Foundation
import UIKit

final class User {

    let login: String
    let password: String
    let name: String
    let avatar: UIImage?
    let status: String

    init(login: String,
         password: String,
         name: String,
         avatar: UIImage?,
         status: String)
    {
        self.login = login
        self.password = password
        self.name = name
        self.avatar = avatar
        self.status = status
    }
}
