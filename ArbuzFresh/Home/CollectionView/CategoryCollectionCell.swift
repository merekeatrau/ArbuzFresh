//
//  HomeCollectionViewCell.swift
//  ArbuzFresh
//
//  Created by Mereke on 19.05.2023.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {

    static let identifier = "CategoryCollectionViewCell"

    private let mainContainerView: UIView = {
        let view = UIView()
        return view
    }()

    private let posterImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "fruits"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .black
        label.text = "Фрукты, \nягоды"
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(mainContainerView)
        mainContainerView.addSubview(posterImageView)
        posterImageView.addSubview(titleLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints() {
        mainContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(12)
        }
    }
}
