//
//  BeerDetailViewController.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import UIKit
import ThemeKit

public protocol BeerDetailDisplayProtocol: AnyObject {
    func displayDetail(_ viewModel: BeerDetailModel.ViewModel)
    func displayError(_ message: String)
    func displayFavoriteStatus(_ isFavorite: Bool)
}

final class BeerDetailViewController: UIViewController {

    var interactor: BeerDetailBusinessProtocol?
    private var isFavorite = false
    
    private var beerDetailView: BeerDetailView {
        return self.view as! BeerDetailView
    }
    private var favoriteButton: UIBarButtonItem?
    
    override func loadView() {
        self.view = BeerDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFavoriteButton()
        interactor?.loadDetail()
    }

    private func setupFavoriteButton() {
       favoriteButton = UIBarButtonItem(
           image: UIImage(systemName: "heart"),
           style: .plain,
           target: self,
           action: #selector(favoriteButtonTapped)
       )
       navigationItem.rightBarButtonItem = favoriteButton
   }
    
    @objc private func favoriteButtonTapped() {
       interactor?.toggleFavorite()
   }
}

extension BeerDetailViewController: BeerDetailDisplayProtocol {
    func displayDetail(_ viewModel: BeerDetailModel.ViewModel) {
        DispatchQueue.main.async {
            self.title = viewModel.title
            self.beerDetailView.configure(with: viewModel)
            self.displayFavoriteStatus( viewModel.isFavorite)
        }
    }

    func displayError(_ message: String) {
        let alert = UIAlertController(
            title: "Erro",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true)
    }

    func displayFavoriteStatus(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
        
        DispatchQueue.main.async {
            let iconName = isFavorite ? "heart.fill" : "heart"
            self.favoriteButton?.image = UIImage(systemName: iconName)
            self.favoriteButton?.tintColor = isFavorite ? .systemRed : AppColor.textOnBrand
        }
    }
}
