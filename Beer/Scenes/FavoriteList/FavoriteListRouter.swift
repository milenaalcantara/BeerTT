import UIKit

protocol FavoriteListRouterProtocol {
    func routeToDetails(beer: Beer)
}

final class FavoriteListRouter: FavoriteListRouterProtocol {
    weak var viewController: UIViewController?
    
    func routeToDetails(beer: Beer) {
        let detailVC = BeerDetailConfigurator.makeModule(beer: beer)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
