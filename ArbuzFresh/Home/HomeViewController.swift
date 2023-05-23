//
//  ViewController.swift
//  ArbuzFresh
//
//  Created by Mereke on 19.05.2023.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    var dataDisplayManager = HomeDataDisplayManager()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.contentInset = .zero
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        return tableView
    }()

    private let searchController: UISearchController = {
        let searchcontroller = UISearchController(searchResultsController: nil)
        searchcontroller.obscuresBackgroundDuringPresentation = false
        searchcontroller.searchBar.placeholder = "Поиск"
        return searchcontroller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavBar()
        setupTableView()
        dataDisplayManager.onSubcategoryDidSelect = { [weak self] subcategory in
            self?.navigationController?.pushViewController(FoodViewController(subcategory: subcategory), animated: true)
        }
    }

    private func setupTableView() {
        tableView.dataSource = dataDisplayManager
        tableView.delegate = dataDisplayManager
        tableView.register(CategoriesTableCell.self, forCellReuseIdentifier: CategoriesTableCell.identifier)
        tableView.register(BannerTableCell.self, forCellReuseIdentifier: BannerTableCell.reuseIdentifier)

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setNavBar() {
        title = "Arbuz Fresh"

        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        let addressLabel = UILabel()
        addressLabel.text = "Гагарина 292"
        addressLabel.textColor = .systemGreen

        let chevronDownImage = UIImage(systemName: "location")
        let chevronDownImageView = UIImageView(image: chevronDownImage)
        chevronDownImageView.tintColor = .systemGreen

        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(customView: addressLabel),
            UIBarButtonItem(customView: chevronDownImageView)
        ]
    }
}
