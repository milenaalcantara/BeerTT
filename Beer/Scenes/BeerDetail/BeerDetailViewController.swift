//
//  BeerDetailViewController.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

import UIKit

public protocol BeerDetailDisplayProtocol: AnyObject {
    func displayDetail(_ viewModel: BeerDetailModel.ViewModel)
    func displayError(_ message: String)
    func displayLoading(_ isLoading: Bool)
    func displayFavoriteStatus(_ isFavorite: Bool)
}

final class BeerDetailViewController: UIViewController {

    var interactor: BeerDetailBusinessProtocol?

    private let beerImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    private var isFavorite = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor?.loadDetail()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(toggleFavorite)
        )

        beerImageView.contentMode = .scaleAspectFit

        titleLabel.font = .boldSystemFont(ofSize: 24)
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = .secondaryLabel
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [
            beerImageView,
            titleLabel,
            subtitleLabel,
            descriptionLabel
        ])
        stack.axis = .vertical
        stack.spacing = 12

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        // Loading
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func toggleFavorite() {
        interactor?.toggleFavorite()
    }
}

// MARK: - Display Logic

extension BeerDetailViewController: BeerDetailDisplayProtocol {

    func displayDetail(_ viewModel: BeerDetailModel.ViewModel) {
        // Se a imagem vier como URL, tentar carregar remota
        if let url = URL(string: viewModel.imageName), viewModel.imageName.starts(with: "http") {
            loadImage(from: url)
        } else {
            beerImageView.image = UIImage(named: viewModel.imageName)
        }

        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        descriptionLabel.text = viewModel.description

        isFavorite = viewModel.isFavorite
        navigationItem.rightBarButtonItem?.image =
            UIImage(systemName: isFavorite ? "heart.fill" : "heart")
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

    func displayLoading(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
            view.isUserInteractionEnabled = false
        } else {
            activityIndicator.stopAnimating()
            view.isUserInteractionEnabled = true
        }
    }

    func displayFavoriteStatus(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
        navigationItem.rightBarButtonItem?.image =
            UIImage(systemName: isFavorite ? "heart.fill" : "heart")
    }
}

private extension BeerDetailViewController {
    func loadImage(from url: URL) {
        // Implementação extremamente simples, sem cache, só para estabilizar
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {

                DispatchQueue.main.async {
                    self.beerImageView.image = image
                }
            }
        }
    }
}
