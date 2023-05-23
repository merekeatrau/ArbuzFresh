//
//  ProductTableCell.swift
//  ArbuzFresh
//
//  Created by Mereke on 22.05.2023.
//

import UIKit

class ProductTableCell: UITableViewCell {
    
    static let identifier = "ProductTableCell"

    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.systemGray6
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { make in
            make.size.equalTo(124)
        }
        return imageView
    }()
        
    private let foodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [foodLabel])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .top
        return stackView
    }()

    
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackView, priceLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var overallStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bannerImageView, rightStackView])
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(overallStackView)
        
        overallStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

    }

    func configure(with product: ProductEntity) {
        if let imageData = product.imageUrl {
            bannerImageView.image = UIImage(named: "\(String(describing: imageData))")
        } else {
            bannerImageView.image = UIImage(named: "banana")
        }
        foodLabel.text = product.name
        let priceString = String(format: "%.2f₸", product.price)
        priceLabel.text = priceString
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
