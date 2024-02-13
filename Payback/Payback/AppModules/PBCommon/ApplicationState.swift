//
//  ApplicationState.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import Foundation

class ApplicationState {

    let networkState: NetworkState

    init(networkState: NetworkState = .init()) {
        self.networkState = networkState
    }

}

class NetworkState {

    var isReachable: Bool

    init(isReachable: Bool = true) {
        self.isReachable = isReachable
    }

}
