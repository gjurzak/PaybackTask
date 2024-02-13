//
//  Reducers.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import Foundation
import ReMVVMCore

struct ApplicationReducer: Reducer {

    static func reduce(state: ApplicationState, with action: StoreAction) -> ApplicationState {
        ApplicationState(
            networkState: NetworkStateReducer.reduce(state: state.networkState, with: action)
        )
    }
}

enum NetworkStateReducer: Reducer {
    static func reduce(state: NetworkState,
                       with action: PBStoreAction.Network) -> NetworkState {

        let newState = state

        switch action {
        case .clear:
            return .init()
        case .isReachable(let isReachable):
            newState.isReachable = isReachable
        }

        return state
    }
}
