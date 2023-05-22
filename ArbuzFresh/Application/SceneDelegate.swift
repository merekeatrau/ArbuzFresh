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

        let mainVC = UINavigationController(rootViewController: FoodViewController())
        mainVC.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), tag: 0)

        let groceryBasketVC = UINavigationController(rootViewController: FoodViewController())
        groceryBasketVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "basket"), tag: 1)

        let profileVC = UINavigationController(rootViewController: UIViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 2)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainVC, groceryBasketVC, profileVC]

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

