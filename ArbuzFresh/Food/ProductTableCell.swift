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
        let imageView = UIImageView(image: UIImage(named: "fruits"))
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
        label.numberOfLines = 0
        return label
    }()
    
    private let priceButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bannerImageView, titleLabel, priceButton])
        stackView.axis = .vertical
        stackView.spacing = 12
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
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bannerImageView.snp.makeConstraints { make in
            make.height.equalTo(bannerImageView.snp.width)
        }
    }
    
    func configure(with title: String, price: String) {
        titleLabel.text = title
        priceButton.setTitle(price, for: .normal)
    }
}
