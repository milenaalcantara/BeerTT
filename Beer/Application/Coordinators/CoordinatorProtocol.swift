//
//  CoordinatorProtocol.swift
//  Beer
//
//  Created by Milena Alcântara on 15/11/25.
//

import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set }
    func start()
}
