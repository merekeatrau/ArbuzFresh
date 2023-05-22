//
//  BannerTableHeader.swift
//  ArbuzFresh
//
//  Created by Mereke on 19.05.2023.
//

import UIKit
import SnapKit

class BannerTableCell: UITableViewCell {

    static let reuseIdentifier = "BannerTableHeader"

    private let bannerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "banner"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        imageView.layer.cornerRadius = 8
        imageView.snp.makeConstraints { make in
            make.height.equalTo(144)
        }
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bannerImageView)
        selectionStyle = .none
        bannerImageView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

