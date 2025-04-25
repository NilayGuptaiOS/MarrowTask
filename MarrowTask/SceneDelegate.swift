//
//  SceneDelegate.swift
//  MarrowTask
//
//  Created by Nilay on 25/04/25.
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let sessionManager = SessionManager()
        let userManager = UserManager()
        let rootView = LaunchScreenView()
            .environmentObject(sessionManager)
            .environmentObject(userManager)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: rootView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        NotificationCenter.default.post(
            name: Notification.Name("AppWillEnterForeground"),
            object: nil
        )
    }
}
