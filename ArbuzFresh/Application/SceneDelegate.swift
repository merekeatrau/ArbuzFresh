//
//  SceneDelegate.swift
//  ArbuzFresh
//
//  Created by Mereke on 19.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let mainVC = createNavigationController(rootViewController: HomeViewController(), title: "Главная", imageName: "house", tag: 0)
        let groceryBasketVC = createNavigationController(rootViewController: BusketViewController(), title: "Корзина", imageName: "basket", tag: 1)
        let profileVC = createNavigationController(rootViewController: ProfileViewController(), title: "Профиль", imageName: "person.circle", tag: 2)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainVC, groceryBasketVC, profileVC]
        
        configureTabBarAppearance()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    private func createNavigationController(rootViewController: UIViewController, title: String, imageName: String, tag: Int) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: imageName), tag: tag)
        return navigationController
    }

    private func configureTabBarAppearance() {
        let selectedColor = UIColor.systemGreen
        UITabBar.appearance().tintColor = selectedColor
        UITabBar.appearance().unselectedItemTintColor = .gray
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

