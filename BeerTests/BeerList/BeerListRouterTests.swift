//
//  BeerListRouterTests.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import XCTest
@testable import Beer
import UIKit

final class BeerListRouterTests: XCTestCase {

    var sut: BeerListRouter!
    var navigation: MockNavigationController!

    override func setUp() {
        sut = BeerListRouter()
        navigation = MockNavigationController()

        let listVC = UIViewController()
        navigation.viewControllers = [listVC]
    }

    func test_navigateToDetail_pushesDetailScreen() {
        let beer = Beer(id: "1", title: "test", type: "mock", description: "default", imageName: "default")
        
        // When
        sut.routeToDetails(beer: beer)

        // Then
        XCTAssertTrue(navigation.didPush)
        XCTAssertTrue(navigation.pushedViewController is FakeDetailVC)

        let pushed = navigation.pushedViewController as! FakeDetailVC
        XCTAssertEqual(pushed.id, 42)
    }
}

// MARK: - Mocks

final class MockNavigationController: UINavigationController {

    var didPush = false
    var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        didPush = true
        pushedViewController = viewController
    }
}

final class FakeDetailVC: UIViewController {
    let id: Int
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }
}

// MARK: - Fake Builder

enum BeerDetailBuilder {
    static func build(id: Int) -> UIViewController {
        FakeDetailVC(id: id)
    }
}
