//
//  HomeTableViewCell.swift
//  ArbuzFresh
//
//  Created by Mereke on 19.05.2023.
//

import UIKit

class CategoriesTableCell: UITableViewCell {

    static let identifier = "HomeViewTableCell"

    var onMovieDidSelect: ((Int) -> Void)?

    func didSelectMovie(with id: Int) {
        onMovieDidSelect?(id)
    }
    
    private let titleLabel: UILabel = {
         let label = UILabel()
         label.text = "Свежие овощи и фрукты"
         label.font = .systemFont(ofSize: 16, weight: .medium)
         return label
     }()

    private let collectionView = CategoriesCollectionView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
