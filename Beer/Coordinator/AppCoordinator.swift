//
//  AppCoordinator.swift
//  Beer
//
//  Created by Milena Alcântara on 15/11/25.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showBeerList()
    }
    
    func showBeerList() {
        
    }
}
