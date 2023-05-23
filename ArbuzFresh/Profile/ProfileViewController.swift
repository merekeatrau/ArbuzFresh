//
//  ProfileViewController.swift
//  ArbuzFresh
//
//  Created by Mereke on 22.05.2023.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    let profilePages: [ProfilePage] = [
        ProfilePage(icon: UIImage(systemName: "square.and.pencil")!, title: "Мереке Атрауов"),
        ProfilePage(icon: UIImage(systemName: "clock.arrow.circlepath")!, title: "История заказов"),
        ProfilePage(icon: UIImage(systemName: "message")!, title: "Служба поддержки"),
        ProfilePage(icon: UIImage(systemName: "mappin.and.ellipse")!, title: "Адреса"),
        ProfilePage(icon: UIImage(systemName: "creditcard")!, title: "Мои карты"),
        ProfilePage(icon: UIImage(systemName: "heart")!, title: "Любимые"),
        ProfilePage(icon: UIImage(systemName: "info.circle")!, title: "О приложении")
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 96
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableCell.self, forCellReuseIdentifier: ProfileTableCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavBar()
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setNavBar() {
        title = "Профиль"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: createLanguageSwitcher())]
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: createSignOutButton())]
    }
    
    private func createSignOutButton() -> UIButton {
        let signOutImage = UIImage(systemName: "rectangle.portrait.and.arrow.forward")
        let signOutButton = UIButton(type: .system)
        signOutButton.setImage(signOutImage, for: .normal)
        signOutButton.tintColor = .systemGreen
        signOutButton.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
        return signOutButton
    }
    
    private func createLanguageSwitcher() -> UISegmentedControl {
        let languages = ["Рус", "Қаз"]
        let languageSwitcher = UISegmentedControl(items: languages)
        languageSwitcher.tintColor = .systemGreen
        languageSwitcher.selectedSegmentTintColor = .systemGreen.withAlphaComponent(0.5)
        languageSwitcher.backgroundColor = .systemGreen.withAlphaComponent(0.25)
        languageSwitcher.selectedSegmentIndex = 0
        languageSwitcher.addTarget(self, action: #selector(languageSwitched(_:)), for: .valueChanged)
        return languageSwitcher
    }
    
    @objc func signOutTapped() {
        print("Sign out tapped")
    }
    
    @objc func languageSwitched(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Russian selected")
        case 1:
            print("Kazakh selected")
        default:
            break
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profilePages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableCell.identifier, for: indexPath) as? ProfileTableCell else {
            return UITableViewCell()
        }
        cell.configure(profilePages[indexPath.row])
        return cell
    }

}
