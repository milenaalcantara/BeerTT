//
//  BeerDetailRouter.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import UIKit

protocol BeerDetailRouterProtocol {
    func close()
}

final class BeerDetailRouter: BeerDetailRouterProtocol {
    weak var viewController: UIViewController?

    func close() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
