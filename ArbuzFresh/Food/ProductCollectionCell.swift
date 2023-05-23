//
//  ProductCollectionCell.swift
//  ArbuzFresh
//
//  Created by Mereke on 22.05.2023.
//

import UIKit
import SnapKit

class ProductCollectionCell: UICollectionViewCell {

    static let reuseIdentifier = "ProductCollectionCell"
    
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
        bannerImageView.image = UIImage(named: "\(product.imageUrl)")
        productLabel.text = "\(product.name), \(product.type.rawValue)"
        let priceString = String(format: "%.2f₸", product.price)
        priceButton.setTitle(priceString, for: .normal)
    }
}

class PriceButton: UIButton {
    let spacing: CGFloat = 10.0

    override func layoutSubviews() {
        super.layoutSubviews()

        if let imageView = imageView, let titleLabel = titleLabel {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
            
            let insetAmount = spacing / 2 + min(imageView.frame.width, titleLabel.frame.width) / 2
            contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }
}
