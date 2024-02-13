//
//  AppConfigurator.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import Foundation
import ReMVVMCore
import ReMVVMExt
import UIKit

struct AppConfigurator {

    static var window: UIWindow?
    static var store: AnyStore?
    static var coordinators: [Any] = []

    @discardableResult static func setupAplication(with state: ApplicationState = .init(),
                                                   on window: UIWindow?,
                                                   debugInfo: Bool) -> AnyStore {

        let appWindow = window ?? UIWindow(frame: UIScreen.main.bounds)
        let allMiddlewares: [AnyMiddleware] = allMiddlewares()

        let store = PBUIApplication.initialize(with: appWindow,
                                               middlewares: allMiddlewares,
                                               state: state,
                                               debugInfo: debugInfo)

        AppConfigurator.window = appWindow
        AppConfigurator.store = store

        AppConfigurator.coordinators = [
            NetworkCoordinator()
        ]

        return store

    }

}

extension AppConfigurator {
    static func allMiddlewares() -> [AnyMiddleware] {
        PBCommonMiddleware.middlewares()
        + PBTransactionsMiddleware.middlewares()
    }
}
