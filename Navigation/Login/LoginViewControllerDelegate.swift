//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by m.khutornaya on 28.09.2022.
//

protocol LoginViewControllerDelegate: AnyObject {
    func check(login: String, password: String) -> Bool
}
