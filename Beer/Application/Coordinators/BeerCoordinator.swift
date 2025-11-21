import UIKit

final class BeerCoordinator {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = BeerListConfigurator.makeModule(coordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }

    func startBeerDetail(beer: Beer) {
        let detailVC = BeerDetailConfigurator.makeModule(beer: beer)
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func startFavoriteList() {
        let favoritesVC = FavoritesListConfigurator.makeModule()
        navigationController.topViewController?.navigationController?.pushViewController(favoritesVC, animated: true)
    }
}
