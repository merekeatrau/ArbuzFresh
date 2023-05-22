//
//  HeaderTableHeader.swift
//  ArbuzFresh
//
//  Created by Mereke on 22.05.2023.
//

import UIKit

class HeaderTableHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = "HeaderTableHeader"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Свежие овощи и фрукты"
        label.textColor = .black
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

