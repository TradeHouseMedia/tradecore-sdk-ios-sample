//
//  AppDelegate.swift
//  TradecoreDemoAppSwift
//
//  Created by Olena Stepaniuk on 14.05.2025.
//

import UIKit
import Tradecore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        initializeTradecore()
        return true
    }
    
    private func initializeTradecore() {
        // Set debugMode if needed.
        TradecoreSDK.shared.debugMode = true
        
        // Set global request parameters if needed.
        let parameters = TradecoreGAMStackRequestParameters()
        parameters.testDeviceIdentifiers = ["00000000-0000000000000000"]
        TradecoreSDK.shared.requestParameters = [parameters]
        
        // Initialize Tradecore SDK with the respective Stack ID and Itunes ID.
        TradecoreSDK.shared.initialize(with: "tradecore-stack-69", itunesId: "123456789")
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {}
}
