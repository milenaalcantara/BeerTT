//
//  BeerList.swift
//  Beer
//
//  Created by Milena Alcântara on 17/11/25.
//
import UIKit

final class BeerListViewController: UIViewController {

    var interactor: BeerListInteractorProtocol?
    var router: BeerListRoutingProtocol?

    private var beers: [BeerCellViewModel] = []

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.fetchBeers(
            request: .init(page: 1, query: nil)
        )
    }
}

extension BeerListViewController {
    private func setupView() {
        title = "Beers"
        view.backgroundColor = .systemBackground

        tableView.register(BeerCell.self, forCellReuseIdentifier: BeerCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension BeerListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        beers.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let vm = beers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: BeerCell.identifier, for: indexPath) as! BeerCell
        cell.configure(with: vm)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectBeer(at: indexPath.row)
    }
}

extension BeerListViewController: BeerListDisplayProtocol {

    func displayBeers(viewModel: BeerListModel.ViewModel) {
        beers = viewModel.beers
        DispatchQueue.main.async { self.tableView.reloadData()
        }
    }

    func displayError(message: String) {
        print("ERROR:", message)
    }
}
