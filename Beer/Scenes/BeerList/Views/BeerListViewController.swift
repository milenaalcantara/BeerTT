//
//  BeerListViewController.swift
//  Beer
//
//  Created by Milena Alcântara on 16/11/25.
//

import UIKit
import ThemeKit

public protocol BeerListDisplayProtocol: AnyObject {
    func displayBeers(viewModel: BeerListModel.ViewModel)
    func displayError()
    func displayLoadingState(isLoading: Bool)
    func displayEmptyState()
}

final class BeerListViewController: UIViewController {

    var interactor: BeerListInteractorProtocol?
    var router: BeerListRoutingProtocol?

    private var beers: [BeerCellViewModel] = []

    // MARK: - Componentes de UI
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(BeerCell.self, forCellReuseIdentifier: BeerCell.identifier)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = .clear
        return table
    }()

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    lazy var emptySearchView: UIView = {
        let emptySearch = UIView(frame: .zero)
         emptySearch.backgroundColor = AppColor.background
        emptySearch.isHidden = true
        emptySearch.translatesAutoresizingMaskIntoConstraints = false
        return emptySearch
    }()

    lazy var searchIcon: UIImageView = {
        let searchIcon = UIImageView(frame: .zero)
        searchIcon.image = UIImage(named: "SearchEmpty")
        searchIcon.tintColor = .systemGray
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        return searchIcon
    }()

    lazy var warningLabel: UILabel = {
        let warningLabel = UILabel(frame: .zero)
        warningLabel.textAlignment = .center
        warningLabel.text = "No result were found"
        warningLabel.font = AppFont.title
        warningLabel.textColor = AppColor.textPrimary
        warningLabel.numberOfLines = 0
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        return warningLabel
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [searchIcon, warningLabel])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.delegate = self
        return search
    }()
    
    private lazy var favoritesButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "folder.fill"),
            style: .plain,
            target: self,
            action: #selector(favoritesButtonTapped)
        )
         button.tintColor = AppColor.textOnBrand
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        setupView()
        
        interactor?.fetchBeers(request: .init(query: nil, type: .initialLoad))
    }

    // MARK: - ViewCode Setup

    private func setupView() {
        title = "Beers"
        view.backgroundColor = AppColor.background
        
        navigationItem.rightBarButtonItem = favoritesButton
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        
        view.addSubview(emptySearchView)
        emptySearchView.addSubview(contentStack)

        setupAllConstraints()
    }
    
    @objc private func favoritesButtonTapped() {
        router?.routeToFavoriteList()
    }
}

extension BeerListViewController {
    private func setupAllConstraints() {
        setupTableViewConstraints()
        setupLoadingIndicatorConstraints()
        setupEmptySearchViewConstraints()
    }
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupLoadingIndicatorConstraints() {
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupEmptySearchViewConstraints() {
        NSLayoutConstraint.activate([
            emptySearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptySearchView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptySearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptySearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentStack.centerXAnchor.constraint(equalTo: emptySearchView.centerXAnchor),
            contentStack.centerYAnchor.constraint(equalTo: emptySearchView.centerYAnchor),
            
            contentStack.leadingAnchor.constraint(equalTo: emptySearchView.leadingAnchor, constant: 40),
            contentStack.trailingAnchor.constraint(equalTo: emptySearchView.trailingAnchor, constant: -40),
            
            searchIcon.widthAnchor.constraint(equalToConstant: 100),
            searchIcon.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}

// MARK: - UITableViewDataSource & Delegate
extension BeerListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = beers[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerCell.identifier, for: indexPath) as? BeerCell else {
             fatalError("Não foi possível carregar BeerCell")
        }
        cell.configure(with: vm)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor?.didSelectBeer(at: indexPath.row)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height - 100 {
            if !searchController.isActive {
                interactor?.fetchBeers(request: .init(query: nil, type: .pagination))
            }
        }
    }
}

// MARK: - UISearchController Delegates

extension BeerListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(executeSearch), object: nil)
        perform(#selector(executeSearch), with: nil, afterDelay: 0.5)
    }

    @objc private func executeSearch() {
        guard let query = searchController.searchBar.text else { return }
        interactor?.fetchBeers(request: .init(query: query, type: .search(query)))
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor?.fetchBeers(request: .init(query: nil, type: .initialLoad))
    }
}

extension BeerListViewController: BeerListDisplayProtocol {

    func displayBeers(viewModel: BeerListModel.ViewModel) {
        DispatchQueue.main.async {
            self.beers = viewModel.beers
            self.tableView.reloadData()
            self.emptySearchView.isHidden = true
            self.tableView.isHidden = false
        }
    }

    func displayError() {
        DispatchQueue.main.async {
            self.searchIcon.image = UIImage(systemName: "wifi.slash")
            self.warningLabel.text = " Connection error: Connect to an internet network."
            
            self.displayEmptyState()
        }
    }

    func displayLoadingState(isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading {
                self.loadingIndicator.startAnimating()
            } else {
                self.loadingIndicator.stopAnimating()
            }
            self.tableView.isUserInteractionEnabled = !isLoading
        }
    }

    func displayEmptyState() {
        DispatchQueue.main.async {
            self.beers = []
            self.tableView.reloadData()
            self.tableView.isHidden = true
            self.emptySearchView.isHidden = false
        }
    }
}
