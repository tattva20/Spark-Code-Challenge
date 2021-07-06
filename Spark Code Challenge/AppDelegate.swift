//
//  AppDelegate.swift
//  Spark Code Challenge
//
//  Created by Octavio Rojas on 04/07/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let injectionContainer = PictureGalleryDependencyContainer()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationController()
        let mainViewController = injectionContainer.makePictureGalleryCollectionViewController()

        navigationController.viewControllers = [mainViewController]

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController

        return true
    }

}
