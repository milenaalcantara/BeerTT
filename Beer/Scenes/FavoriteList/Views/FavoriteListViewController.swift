//
//  FavoriteListViewController.swift
//  Beer
//
//  Created by Milena Alcântara on 21/11/25.
//

import UIKit
import ThemeKit

protocol FavoritesListDisplayProtocol: AnyObject {
    func displayFavorites(viewModel: [BeerCellViewModel])
    func displayEmptyState()
}

final class FavoritesListViewController: UIViewController {
    
    var interactor: FavoriteListInteractorProtocol?
    var router: FavoriteListRouterProtocol?
    
    private var favorites: [BeerCellViewModel] = []
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(BeerCell.self, forCellReuseIdentifier: BeerCell.identifier)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "You don't have any favorites yet."
        label.textAlignment = .center
        label.textColor = .gray
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAllConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchFavorites()
    }
    
    private func setupView() {
        title = "Favorites"
        view.backgroundColor = AppColor.background
        view.addSubview(tableView)
        view.addSubview(emptyLabel)
    }
    
    private func setupAllConstraints() {
        setupTableViewConstraints()
        setupEmptyLabelConstraints()
    }
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupEmptyLabelConstraints() {
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension FavoritesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerCell.identifier, for: indexPath) as? BeerCell else {
            return UITableViewCell()
        }
        cell.configure(with: favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor?.didSelectFavorite(at: indexPath.row)
    }
}

extension FavoritesListViewController: FavoritesListDisplayProtocol {
    func displayFavorites(viewModel: [BeerCellViewModel]) {
        self.favorites = viewModel
        self.tableView.isHidden = false
        self.emptyLabel.isHidden = true
        self.tableView.reloadData()
    }
    
    func displayEmptyState() {
        self.favorites = []
        self.tableView.reloadData()
        self.tableView.isHidden = true
        self.emptyLabel.isHidden = false
    }
}
