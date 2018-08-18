//
//  RestaurantSearchViewController.swift
//  Lists
//
//  Created by Tony Albor on 5/6/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import UIKit

protocol NibIdentifiable {
    static var nibName: String { get }
}

extension NibIdentifiable {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableView {
    func registerCell<Cell: UITableViewCell>(_: Cell.Type = Cell.self) where Cell: Reusable {
        register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(_: Cell.Type = Cell.self) -> Cell where Cell: Reusable {
        return dequeueReusableCell(withIdentifier: Cell.reuseIdentifier) as! Cell
    }
}

extension UICollectionView {
    func registerCell<Cell: UICollectionViewCell>(_: Cell.Type = Cell.self) where Cell: Reusable {
        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func dequeueResuableCell<Cell: UICollectionViewCell>(_: Cell.Type = Cell.self, indexPath: IndexPath) -> Cell where Cell: Reusable {
        return dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    }
}

class RestaurantSearchViewController: UIViewController, NibIdentifiable {

    @IBOutlet private weak var tableView: UITableView!
    
    private let context: RestaurantSearchContext
    private var searchBar: UISearchBar!
    
    init(context: RestaurantSearchContext) {
        self.context = context
        super.init(nibName: RestaurantSearchViewController.nibName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpTableView()
    }
    
    private func setUpNavBar() {
        navigationItem.title = "Results" // use actual search term
        let search = UISearchController(searchResultsController: nil)
//        search.searchResultsUpdater = self
        navigationItem.searchController = search
        searchBar = search.searchBar
        searchBar.delegate = self
        setUpMapsButton()
    }
    
    private func setUpMapsButton() {
        let button = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(didTapMaps))
        navigationItem.rightBarButtonItem = button
        button.isEnabled = false
    }
    
    @objc
    private func didTapMaps() {
        func toAnnotation(restaurant: RestaurantSearchResult) -> MapAnnotation {
            return MapAnnotation(coordinate: restaurant.coordinates,
                                 title: restaurant.name,
                                 subtitle: nil)
        }
        let mapContext = MapContext(locationManager: context.locationManager,
                                    annotations: context.results.map(toAnnotation))
        let map = MapViewController(context: mapContext)
        let navigation = UINavigationController(rootViewController: map)
        present(navigation, animated: true, completion: nil)
    }
    
    private func setUpTableView() {
        tableView.registerCell(RestaurantSearchResultTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
    }
}

extension RestaurantSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return context.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(RestaurantSearchResultTableViewCell.self)
        cell.result = context.results[indexPath.row]
        return cell
    }
}

extension RestaurantSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let network = Network.default
        let detailService = YelpRestaurantDetailService(network: network)
        let detailContext = RestaurantDetailContext(service: detailService)
        let detail = RestaurantDetailViewController(context: detailContext, searchResult: context.results[indexPath.row], allResults: context.results)
        navigationController?.pushViewController(detail, animated: true)
    }
}

extension RestaurantSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        context.getResults(query: searchBar.text ?? "") { [weak self] result in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.navigationItem.rightBarButtonItem?.isEnabled = (result.value?.count ?? 0) > 0
            }
        }
    }
}

//extension RestaurantSearchViewController: UISearchResultsUpdating {
//
//    func updateSearchResults(for searchController: UISearchController) {
//        if let text = searchController.searchBar.text, !text.isEmpty {
//
//        } else {
//
//        }
//    }
//}
