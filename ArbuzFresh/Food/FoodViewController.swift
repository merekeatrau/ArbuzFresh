//
//  FoodViewController.swift
//  ArbuzFresh
//
//  Created by Mereke on 22.05.2023.
//

import UIKit
import SnapKit

class FoodViewController: UIViewController {
    
    var productsBySubcategory: [Product] = []
    
    let subcategory: Subcategory
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 16.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(ProductCollectionCell.self, forCellWithReuseIdentifier: "ProductCollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        return searchController
    }()
    
    init(subcategory: Subcategory) {
        self.subcategory = subcategory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getProductsBySubcategory(subcategory)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        setCollectionView()
        setNavBar()
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setNavBar() {
        title = "\(subcategory.rawValue)"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        let filterLabel = UILabel()
        filterLabel.text = "Фильтры"
        filterLabel.textColor = .systemGreen
        let chevronDownImage = UIImage(systemName: "slider.horizontal.3")
        let chevronDownImageView = UIImageView(image: chevronDownImage)
        chevronDownImageView.tintColor = .systemGreen
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: filterLabel),
            UIBarButtonItem(customView: chevronDownImageView)
        ]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .systemGreen
    }

}

extension FoodViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsBySubcategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.reuseIdentifier, for: indexPath) as! ProductCollectionCell
        let product = productsBySubcategory[indexPath.row]
        cell.configure(product: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16.0
        let collectionViewSize = collectionView.frame.size.width - padding * 3
        return CGSize(width: collectionViewSize/2, height: collectionViewSize*0.75)
    }
}

extension FoodViewController {
    func getProductsBySubcategory(_ subcategory: Subcategory) {
        productsBySubcategory = products.values.flatMap { $0.flatMap { $0.filter { $0.subcategory == subcategory } } }
    }
}
