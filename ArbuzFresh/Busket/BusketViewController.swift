//
//  BusketViewController.swift
//  ArbuzFresh
//
//  Created by Mereke on 22.05.2023.
//

import UIKit
import SnapKit
import CoreData

class BusketViewController: UIViewController {
    
    private var totalAmount: Int?
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .productAddedToCart, object: nil)
    }
    
    private lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    private var fetchedProducts: [ProductEntity] = []
    
    private let proceedToCheckoutButton: UIButton = {
        let button = UIButton(type: .system)
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
        fetchSavedProducts()
        countTotalAmount()
        NotificationCenter.default.addObserver(self, selector: #selector(productAddedToCart(_:)), name: .productAddedToCart, object: nil)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductTableCell.self, forCellReuseIdentifier: ProductTableCell.identifier)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.reloadData()
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
        return fetchedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableCell.identifier, for: indexPath) as? ProductTableCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: fetchedProducts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            self?.removeProduct(at: indexPath)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

extension BusketViewController {
    func fetchSavedProducts() {
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        
        do {
            fetchedProducts = try context.fetch(fetchRequest)
            tableView.reloadData()
            print("Fetched \(fetchedProducts.count) products from CoreData.")
        } catch {
            print("Failed to fetch products from CoreData: \(error)")
        }
        self.tableView.reloadData()
    }
    
    private func countTotalAmount() {
        totalAmount = fetchedProducts.reduce(0) { $0 + Int($1.price) }
        let totalAmountText = totalAmount != nil ? "\(totalAmount!)" : "0"
        proceedToCheckoutButton.setTitle("Перейти к оплате\n\(totalAmountText) ₸", for: .normal)
    }
    
    @objc private func productAddedToCart(_ notification: Notification) {
        if let product = notification.userInfo?["product"] as? Product {
            fetchSavedProducts()
            tableView.reloadData()
            countTotalAmount()
        }
    }
    
    func removeProduct(at indexPath: IndexPath) {
        let productToRemove = fetchedProducts[indexPath.row]
        
        context.delete(productToRemove)
        do {
            try context.save()
        } catch {
            print("Failed to remove product from CoreData: \(error)")
        }
        
        fetchedProducts.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        countTotalAmount()
    }
}

extension Notification.Name {
    static let productAddedToCart = Notification.Name("productAddedToCart")
}
