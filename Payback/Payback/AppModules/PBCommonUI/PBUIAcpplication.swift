//
//  PBUIAcpplication.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import Combine
import Foundation
import Loaders
import ReMVVMCore
import ReMVVMExt
import UIKit

private enum LaunchScreen: Storyboard, HasInitialController {
    static var bundle = Bundle.main
}

class PBUIApplication {

    static func initialize(with window: UIWindow,
                           middlewares: [AnyMiddleware],
                           state: ApplicationState = .init(),
                           debugInfo: Bool) -> AnyStore {

        let uiStateConfig = UIStateConfig(
            initialController: LaunchScreen.instantiateInitialViewController(),

            navigationController: {
                let controller = PBNavigationController()

                return controller
            },
            navigationConfigs: [],
            navigationBarHidden: false
        )

        let mappers: [StateMapper<ApplicationState>] = [
            StateMapper(for: \.networkState)
        ]

        let logger = debugInfo ? Logger(tag: "PB-Store", option: [.dispatch(), .middleware(), .reduce()]) : .noLogger
        let store = ReMVVMExtension.initialize(with: state,
                                               window: window,
                                               uiStateConfig: uiStateConfig,
                                               stateMappers: mappers,
                                               reducer: ApplicationReducer.self,
                                               middleware: middlewares,
                                               logger: logger)

        return store
    }

}
