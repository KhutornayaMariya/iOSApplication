//
//  RootTabBarViewController.swift
//  Navigation
//
//  Created by m.khutornaya on 03.10.2022.
//

import UIKit

class RootTabBarViewController: UITabBarController {

    private let feedViewController = Factory(flow: .feed)

    private let profileViewController = Factory(flow: .profile)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setControllers()
    }

    private func setControllers() {
        viewControllers = [
            feedViewController.navigationController,
            profileViewController.navigationController
        ]
    }
}
