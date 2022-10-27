//
//  User.swift
//  Navigation
//
//  Created by m.khutornaya on 26.09.2022.
//

import UIKit

final class User {
    let name: String
    let avatar: UIImage?
    let status: String

    init(name: String,
         avatar: UIImage?,
         status: String)
    {
        self.name = name
        self.avatar = avatar
        self.status = status
    }
}
