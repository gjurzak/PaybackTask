//
//  NetworkCoordinator.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 13/02/2024.
//

import Combine
import Foundation
import Network
import ReMVVMCore
import TTGSnackbar
import UIKit

public class NetworkCoordinator {

    @ReMVVM.Dispatcher private var dispatcher
    @ReMVVM.State private var state: ApplicationState?

    private var monitor: NWPathMonitor

    private var queue = DispatchQueue(label: "NetworkMonitor")
    private var subscriptions = Set<AnyCancellable>()

    init() {

        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?._dispatcher.dispatch(action: PBStoreAction.Network.isReachable(path.status == .satisfied))
            }
        }
        monitor.start(queue: queue)

        $state.map { $0.networkState.isReachable }
            .removeDuplicates()
            .scan((true, true)) { ($0.1, $1) }
            .filter { $0 != $1 }
            .map { $1 }
            .sink(receiveValue: { isReachable in
                if isReachable {
                    let message = "Good news! Internet access is back."
                    let snackBar = TTGSnackbar(message: message, duration: .short)
                    snackBar.backgroundColor = UIColor.blue
                    snackBar.show()
                } else {
                    let message = "You are offline. Please check your internet connection."
                    let snackBar = TTGSnackbar(message: message, duration: .middle)
                    snackBar.backgroundColor = UIColor.red
                    snackBar.show()
                }
            })
            .store(in: &subscriptions)

    }

}
