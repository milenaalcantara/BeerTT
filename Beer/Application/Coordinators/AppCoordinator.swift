//
//  AppCoordinator.swift
//  Beer
//
//  Created by Milena Alcântara on 15/11/25.
//

import UIKit
import ThemeKit

final class AppCoordinator: CoordinatorProtocol {
    private let window: UIWindow
    var navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let beerCoordinator = BeerCoordinator(navigationController: navigationController)
        beerCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        setupAppearence()
    }
    
    func setupAppearence() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColor.brandPrimary
        appearance.largeTitleTextAttributes = [.foregroundColor: AppColor.textOnBrand]
        appearance.titleTextAttributes = [.foregroundColor: AppColor.textOnBrand]

        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.tintColor = AppColor.textOnBrand
    }
}
