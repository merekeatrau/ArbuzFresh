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
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "banana"))
        imageView.backgroundColor = UIColor.systemGray6
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let titleLabel: UILabel = {
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
        [bannerImageView, titleLabel, priceButton].forEach { stackView.addArrangedSubview($0) }
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
    
    func configure(with title: String, price: String) {
        titleLabel.text = title
        priceButton.setTitle(price, for: .normal)
    }
}

class PriceButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        guard let imageView = imageView, let titleLabel = titleLabel else {
            return
        }

        let offset: CGFloat = (bounds.width - (titleLabel.frame.width + imageView.frame.width)) / 2
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -offset, bottom: 0, right: offset)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: offset, bottom: 0, right: -offset*2)
    }
}
