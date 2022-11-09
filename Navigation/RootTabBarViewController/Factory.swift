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
    private lazy var loginDelegate: LoginViewControllerDelegate = LoginInspector()

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
            let model = ProfileViewModel(user: CurrentUserService().getUser())
            let isAuthorized = AuthorizationModel.defaultModel.credential == nil ? false : true
            let controller = isAuthorized ? ProfileViewController(viewModel: model) : LogInViewController()

            profileCoordinator.navController = navigationController
            navigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "house"), selectedImage: nil)
            navigationController.setViewControllers([controller], animated: true)
        }
    }
}
