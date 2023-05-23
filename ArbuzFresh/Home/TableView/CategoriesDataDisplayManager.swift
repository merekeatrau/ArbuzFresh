//
//  HomeDataDisplayManager.swift
//  ArbuzFresh
//
//  Created by Mereke on 19.05.2023.
//

import UIKit

final class HomeDataDisplayManager: NSObject, UITableViewDataSource, UITableViewDelegate  {
    
    var onSubcategoryDidSelect: ((Int) -> Void)?
        
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableCell.reuseIdentifier, for: indexPath)
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableCell.identifier, for: indexPath) as! CategoriesTableCell
            cell.categoryLabel.text = "Свежие овощи и фрукты"
            cell.products = products[.fruitsAndVegetables] ?? []
            cell.onSubcategoryDidSelect = onSubcategoryDidSelect
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableCell.identifier, for: indexPath) as! CategoriesTableCell
            cell.categoryLabel.text = "Молочные продукты"
            cell.products = products[.milkProducts] ?? []
            cell.onSubcategoryDidSelect = onSubcategoryDidSelect
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableView.automaticDimension
        } else {
            return tableView.frame.height * 0.33
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
}
