import UIKit

final class BeerCoordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        print("start Beer coordinator")
        let viewController = BeerListConfigurator.makeModule()
        navigationController.pushViewController(viewController, animated: false)
    }

    func startBeerDetail(beer: Beer) {
        let detailVC = BeerDetailConfigurator.makeModule(beer: beer)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
