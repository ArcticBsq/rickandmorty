//
//  SceneDelegate.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 04.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        //MARK: Создание nav controller в коде
        let nav = UINavigationController()
        let mainView = MainViewController(nibName: nil, bundle: nil)
        nav.viewControllers = [mainView]
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.systemGreen, NSAttributedString.Key.font : UIFont(name: "Apple SD Gothic Neo", size: 24)!]
        // Цвет nav bar
        UINavigationBar.appearance().barTintColor = Colors.systemGreen
        UINavigationBar.appearance().tintColor = Colors.systemGreen
        
        // Убрать разделительную линию nav controller
        nav.navigationBar.setBackgroundImage(UIImage(), for:.default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.layoutIfNeeded()
        
        
        guard let windowScene = ( scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

