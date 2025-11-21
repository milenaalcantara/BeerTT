//
//  BeerDetailRouterTests.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

//
//  BeerDetailRouterTests.swift
//  BeerTests
//

import XCTest
@testable import Beer

final class BeerDetailRouterTests: XCTestCase {

    func test_routeToBack_popsNavigation() {

        let sut = BeerDetailRouter()
        let nav = UINavigationController()
        let vc = UIViewController()
        nav.viewControllers = [vc]

        sut.viewController = vc

        sut.close()

        XCTAssertEqual(nav.viewControllers.count, 1)
    }
}
