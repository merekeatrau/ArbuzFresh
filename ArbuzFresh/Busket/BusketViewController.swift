//
//  BusketViewController.swift
//  ArbuzFresh
//
//  Created by Mereke on 22.05.2023.
//

import UIKit
import SnapKit

class BusketViewController: UIViewController {
    
    private let proceedToCheckoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Перейти к оплате\n4324 ₸", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 24
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInset = .zero
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavBar()
        setupTableView()
        setButton()
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
    
    private func setButton() {
        view.addSubview(proceedToCheckoutButton)
        proceedToCheckoutButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            $0.height.equalTo(48)
        }
        proceedToCheckoutButton.addTarget(self, action: #selector(proceedToCheckoutButtonTapped), for: .touchUpInside)
    }
    
    @objc private func proceedToCheckoutButtonTapped() {
        let subscriptionVC = SubscriptionViewController()
        subscriptionVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(subscriptionVC, animated: true)
    }
    
    private func setNavBar() {
        title = "Корзина"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
