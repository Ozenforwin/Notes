//
//  SceneDelegate.swift
//  Notes
//
//  Created by Dyadichev on 21.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let myWindow = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        let viewController = NotesViewController()
        
        navigationController.viewControllers = [viewController]
        myWindow.rootViewController = navigationController
        
        self.window = myWindow
        
        myWindow.makeKeyAndVisible()
    }
}

