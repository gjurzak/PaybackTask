//
//  TransactionDetatailsMiddleware.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import ReMVVMCore
import ReMVVMExt

struct TransactionsDetailsMiddleware: Middleware {

    typealias State = ApplicationState
    typealias Action = PBUIAction.TransactionDetails

    func onNext(for state: State,
                action: Action,
                interceptor: Interceptor<Action, State>,
                dispatcher: Dispatcher) {

        let viewModel = TransactionDetailsViewModel(transaction: action.transaction)
        let action = Push(view: TransactionDetailsView(viewModel: viewModel))
        dispatcher.dispatch(action: action)

    }

}
