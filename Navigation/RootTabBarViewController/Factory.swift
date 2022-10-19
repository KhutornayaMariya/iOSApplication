//
//  Factory.swift
//  Navigation
//
//  Created by m.khutornaya on 03.10.2022.
//

import UIKit

final class Factory {

    enum Flow {
        case feed
        case profile
    }

    let navigationController: UINavigationController = UINavigationController()
    let flow: Flow

    init(
        flow: Flow
    ) {
        self.flow = flow
        startModule()
    }

    func startModule() {
        switch flow {
        case .feed:
            let feedCoordinator = FeedCoordinator()
            let controller = FeedViewController(.systemGray6, "News", parent: navigationController)
            feedCoordinator.navController = navigationController
            navigationController.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "doc"), selectedImage: nil)
            navigationController.setViewControllers([controller], animated: true)
        case .profile:
            let profileCoordinator = ProfileCoordinator()
            let controller = LogInViewController()
            profileCoordinator.navController = navigationController
            navigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "house"), selectedImage: nil)
            navigationController.setViewControllers([controller], animated: true)
        }
    }
}
