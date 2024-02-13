//
//  TransactionsMiddleware.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import ReMVVMCore
import ReMVVMExt

struct TransactionsMiddleware: Middleware {

    typealias State = ApplicationState
    typealias Action = PBUIAction.Transactions

    func onNext(for state: State,
                action: Action,
                interceptor: Interceptor<Action, State>,
                dispatcher: Dispatcher) {

        let action = ShowOnRoot(view: TransactionsView(), navigationBarHidden: false)
        dispatcher.dispatch(action: action)

    }

}
