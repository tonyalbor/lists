//
//  RestaurantSearchViewController.swift
//  Lists
//
//  Created by Tony Albor on 5/6/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import RxCocoa
import RxSwift
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

class RestaurantSearchViewController: UIViewController, NibIdentifiable {

    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel: RestaurantSearchViewModel
    private var searchBar: UISearchBar!
    private let disposeBag = DisposeBag()
    
    init(viewModel: RestaurantSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: RestaurantSearchViewController.nibName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpTableView()
        bindViewModel()
    }
    
    private func setUpNavBar() {
        navigationItem.title = "Results" // use actual search term
        let search = UISearchController(searchResultsController: nil)
//        search.searchResultsUpdater = self
        navigationItem.searchController = search
        searchBar = search.searchBar
    }
    
    private func setUpTableView() {
        tableView.registerCell(RestaurantSearchResultTableViewCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func bindViewModel() {
        let input = RestaurantSearchViewModel.Input(
            query: searchBar.rx.text.asDriver())
        let output = viewModel.transform(input: input)
        output.results
            .drive(tableView.rx.items) { table, index, result in
                let cell = table.dequeueReusableCell(RestaurantSearchResultTableViewCell.self)
                cell.result = result
                return cell
            }
            .disposed(by: disposeBag)
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
