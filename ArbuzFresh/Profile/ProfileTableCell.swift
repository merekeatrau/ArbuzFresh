//
//  ProfileTableCell.swift
//  ArbuzFresh
//
//  Created by Mereke on 22.05.2023.
//

import UIKit

class ProfileTableCell: UITableViewCell {
    
    static let identifier = "ProfileTableCell"
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemGreen
        imageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
        return imageView
    }()
    
    private let pageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Mereke Atrauov"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let arrowIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray.withAlphaComponent(0.3)
        return imageView
    }()
    
    private let mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconView, pageLabel, arrowIcon])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(mainContainer)
        mainContainer.addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        mainContainer.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
    }
    
    func configure(_ info: ProfilePage) {
        pageLabel.text = info.title
        iconView.image = info.icon
    }
}


