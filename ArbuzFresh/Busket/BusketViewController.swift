//
//  BusketViewController.swift
//  ArbuzFresh
//
//  Created by Mereke on 22.05.2023.
//

import UIKit
import SnapKit

class BusketViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
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
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductTableCell.self, forCellReuseIdentifier: ProductTableCell.identifier)

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setNavBar() {
        title = "Корзина"

        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        let titleLabel = UILabel()
        titleLabel.text = "Гагарина 292"
        titleLabel.textColor = .systemGreen

        let chevronDownImage = UIImage(systemName: "location")
        let chevronDownImageView = UIImageView(image: chevronDownImage)
        chevronDownImageView.tintColor = .systemGreen

        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(customView: titleLabel),
            UIBarButtonItem(customView: chevronDownImageView)
        ]
    }
}

extension BusketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableCell.identifier, for: indexPath) as? ProductTableCell else {
            return UITableViewCell()
        }
        return cell
    }
}
