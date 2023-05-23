//
//  HomeTableViewCell.swift
//  ArbuzFresh
//
//  Created by Mereke on 19.05.2023.
//

import UIKit

class CategoriesTableCell: UITableViewCell, SubcategoryCellDelegate {
    
    static let identifier = "CategoriesTableCell"
    
    var onSubcategoryDidSelect: ((Int) -> Void)?
    
    func didSelectSubcategoryCellDelegate(with subcategory: Int) {
        onSubcategoryDidSelect?(subcategory)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
        collectionView.subcategories = []
        collectionView.collectionView.reloadData()
    }
    
    var products: [[Product]] = [] {
        didSet {
            collectionView.subcategories = products.map { $0[0].subcategory }
            collectionView.collectionView.reloadData()
        }
    }
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    let collectionView = CategoriesCollectionView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        collectionView.subcategories = products.map { $0[0].subcategory }
        collectionView.subcategoryDelegate = self
        selectionStyle = .none

        contentView.addSubview(categoryLabel)
        contentView.addSubview(collectionView)

        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
