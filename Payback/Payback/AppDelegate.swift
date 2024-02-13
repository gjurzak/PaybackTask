//
//  AppDelegate.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import ReMVVMCore
import ReMVVMExt
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var debugInfo: Bool { true }

    private var store: AnyStore!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        store = AppConfigurator.setupAplication(on: window, debugInfo: debugInfo)

        store.dispatch(action: PBUIAction.Transactions.show)

        return true
    }

}
