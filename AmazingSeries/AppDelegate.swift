//
//  AppDelegate.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: ListSeriesRoutingLogic?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        registerDependencies()
        startScene()
        
        return true
    }
    
    private func startScene() {
        let configurator = ListSeriesConfigurator()
        let navigationController = UINavigationController(rootViewController: configurator.resolveViewController())

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func registerDependencies() {
        DependencyContainer.register(NetworkManager(), forMetaType: NetworkManagerProtocol.self)
        DependencyContainer.register(ImageDownloader(), forMetaType: ImageDownloaderProtocol.self)
    }
}

