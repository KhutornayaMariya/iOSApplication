//
//  UserServiceProtocol.swift
//  Navigation
//
//  Created by m.khutornaya on 26.09.2022.
//

import Foundation

protocol UserServiceProtocol {
    func getUser(login: String?, password: String?) -> User?
}
