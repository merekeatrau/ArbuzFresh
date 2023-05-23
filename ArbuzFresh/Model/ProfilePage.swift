//
//  File.swift
//  ArbuzFresh
//
//  Created by Mereke on 22.05.2023.
//

import Foundation
import UIKit

struct ProfilePage {
    let icon: UIImage
    let title: String
    
    init(icon: UIImage, title: String) {
        self.icon = icon
        self.title = title
    }
}

let profilePages: [ProfilePage] = [
    ProfilePage(icon: UIImage(systemName: "square.and.pencil")!, title: "Мереке Атрауов"),
    ProfilePage(icon: UIImage(systemName: "clock.arrow.circlepath")!, title: "История заказов"),
    ProfilePage(icon: UIImage(systemName: "message")!, title: "Служба поддержки"),
    ProfilePage(icon: UIImage(systemName: "mappin.and.ellipse")!, title: "Адреса"),
    ProfilePage(icon: UIImage(systemName: "creditcard")!, title: "Мои карты"),
    ProfilePage(icon: UIImage(systemName: "heart")!, title: "Любимые"),
    ProfilePage(icon: UIImage(systemName: "info.circle")!, title: "О приложении")
]
