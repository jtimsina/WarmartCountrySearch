//
//  CountriesListViewController.swift
//  WarmartCountrySearch
//
//  Created by Jai Timsina on 4/22/25.
//

import UIKit

class CountriesListViewController: UIViewController {

    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel = CountryViewModel(netowrkManager: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries List"
        view.backgroundColor = .white

        setupTableView()
        setupSearchController()
        setupClosures()

        viewModel.fetchCountries(urlString: APIEndpoints.CountryListEndpoint)
    }

    private func setupTableView() {
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryCell")
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(contentSizeCategoryChanged), name: UIContentSizeCategory.didChangeNotification, object: nil)

        view.addSubview(tableView)

    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search by Name or Region"
        searchController.searchBar.searchTextField.adjustsFontForContentSizeCategory = true
        
        navigationItem.title = "Countries List"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupClosures() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: errorMessage)
            }
        }
    }
    private func showErrorAlert(message: String) {
         let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.setValue(NSAttributedString(string: message, attributes: [.font: UIFont.preferredFont(forTextStyle: .body)]), forKey: "attributedMessage")

         DispatchQueue.main.async {
             self.present(alert, animated: true)
         }
     }
    
    @objc private func contentSizeCategoryChanged() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CountriesListViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            viewModel.filterCountries(searchText: searchText)
        }
    }
}

extension CountriesListViewController:UITableViewDataSource{
    // MARK: - TableView DataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCountries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.filteredCountries[indexPath.row])
        return cell
    }

}


extension CountriesListViewController:UITableViewDelegate{
    // MARK: - TableView Delegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.filteredCountries[indexPath.row].name)
    }
}
