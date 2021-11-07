//
//  SceneDelegate.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let sceneFactory = ListSeriesConfigurator()
        let navController = UINavigationController(rootViewController: sceneFactory.resolveViewController())
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

