//
//  MainCoordinator.swift
//  Navigation
//
//  Created by m.khutornaya on 03.10.2022.
//

import UIKit

protocol MainCoordinatorProtocol {
    func startApplication() -> UIViewController
}

final class MainCoordinator: MainCoordinatorProtocol {
    func startApplication() -> UIViewController {
        return RootTabBarViewController()
    }
}
