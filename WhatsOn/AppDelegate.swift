//
//  AppDelegate.swift
//  Netflix
//
//  Created by Maxime Maheo on 19/02/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    private lazy var mainWindow = UIWindow()

    private let router = AppCoordinator().strongRouter

    // MARK: - Methods
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureAppUI()

        router.setRoot(for: mainWindow)

        return true
    }

    private func configureAppUI() {
        UITabBar.appearance().barTintColor = .darkGrey600
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = .white

        UINavigationBar.appearance().barTintColor = .darkGrey900
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().tintColor = .white
    }
}
