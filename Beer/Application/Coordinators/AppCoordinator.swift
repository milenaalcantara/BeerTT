//
//  AppCoordinator.swift
//  Beer
//
//  Created by Milena Alcântara on 15/11/25.
//

import UIKit
import ThemeKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set }
    func start()
}

final class AppCoordinator: CoordinatorProtocol {
    private let window: UIWindow
    var navigationController: UINavigationController
    
    private var beerCoordinator: BeerCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let beerCoordinator = BeerCoordinator(navigationController: navigationController)
        self.beerCoordinator = beerCoordinator
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
        
        setupSearchBarAppearence()
    }
    
    func setupSearchBarAppearence() {
        UISearchBar.appearance().tintColor = AppColor.textOnBrand
        let searchTextField = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        searchTextField.textColor = AppColor.textPrimary
        searchTextField.backgroundColor = .white
        UISearchBar.appearance().setImage(UIImage(systemName: "magnifyingglass"), for: .search, state: .normal)
    }
}
