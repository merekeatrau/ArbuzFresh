//
//  ProductCollectionCell.swift
//  ArbuzFresh
//
//  Created by Mereke on 22.05.2023.
//

import UIKit
import SnapKit
import CoreData

class ProductCollectionCell: UICollectionViewCell {
        
    static let reuseIdentifier = "ProductCollectionCell"
            
    private var product: Product?
        
    override func prepareForReuse() {
        super.prepareForReuse()
        bannerImageView.image = nil
        productLabel.text = nil
    }
        
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "banana"))
        imageView.backgroundColor = UIColor.systemGray6
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let productLabel: UILabel = {
        let label = UILabel()
        label.text = "Яблоко голден Ред Принц Польша, кг"
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let priceButton: PriceButton = {
        let button = PriceButton()
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        let image = UIImage(systemName: "plus")?
            .applyingSymbolConfiguration(UIImage.SymbolConfiguration(scale: .small))?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setTitle("633₸", for: .normal)
        button.addTarget(self, action: #selector(priceButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(stackView)
        [bannerImageView, productLabel, priceButton].forEach { stackView.addArrangedSubview($0) }
        
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bannerImageView.snp.makeConstraints { make in
            make.height.equalTo(bannerImageView.snp.width)
        }
        priceButton.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }
    
    func configure(product: Product) {
        self.product = product
        bannerImageView.image = UIImage(named: "\(product.imageUrl)")
        productLabel.text = "\(product.name), \(product.type.rawValue)"
        let priceString = String(format: "%.2f₸", product.price)
        priceButton.setTitle(priceString, for: .normal)
    }
}


extension ProductCollectionCell {
    
    @objc private func priceButtonTapped() {
        guard let product = product else {
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ProductEntity", in: context)!
        let productEntity = NSManagedObject(entity: entity, insertInto: context)
        
        productEntity.setValue(product.id, forKey: "id")
        productEntity.setValue(product.name, forKey: "name")
        productEntity.setValue(product.category.rawValue, forKey: "category")
        productEntity.setValue(product.subcategory.rawValue, forKey: "subcategory")
        productEntity.setValue(product.type.rawValue, forKey: "type")
        productEntity.setValue(product.price, forKey: "price")
        productEntity.setValue(product.imageUrl, forKey: "imageUrl")
        
        do {
            try context.save()
            NotificationCenter.default.post(name: .productAddedToCart, object: nil, userInfo: ["product": product])
        } catch {
            print(error)
        }
    }
}

