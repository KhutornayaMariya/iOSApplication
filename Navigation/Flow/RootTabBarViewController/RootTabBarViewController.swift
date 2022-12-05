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

    private let favoritesViewController = Factory(flow: .favorites)

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .systemGray6)
        setControllers()
    }

    private func setControllers() {
        viewControllers = reloadViewControllers()
    }
}

extension RootTabBarViewController: RootTabBarViewControllerProtocol {

    func reloadViewControllers() -> [UIViewController] {
        return [
            feedViewController.navigationController,
            profileViewController.navigationController,
            favoritesViewController.navigationController
        ]
    }
}
