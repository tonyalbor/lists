//
//  ListsViewController.swift
//  Lists
//
//  Created by Tony Albor on 8/4/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import Alamofire
import UIKit

class ListsViewController: UIViewController {
    
    override func loadView() {
        view = ListsView()
    }
    
    var contentView: ListsView { return view as! ListsView }
    var tableView: UITableView { return contentView.tableView }
    
    private let context: ListsContext
    
    init(context: ListsContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpTableView()
        context.getLists { [weak tableView] _ in
            DispatchQueue.main.async {
                tableView?.reloadData()
            }
        }
    }
    
    private func setUpNavigationBar() {
        navigationItem.title = "Lists"
    }
    
    private func setUpTableView() {
        tableView.registerCell(ListTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60.0
    }
}

extension ListsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return context.lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = context.lists[indexPath.row]
        let cell = tableView.dequeueReusableCell(ListTableViewCell.self)
        cell.name.text = list.name
        return cell
    }
}

extension ListsViewController: UITableViewDelegate {
    
}
