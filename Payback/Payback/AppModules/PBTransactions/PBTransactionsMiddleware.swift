//
//  PBTransactionsMiddleware.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import Foundation
import ReMVVMCore
import ReMVVMExt

struct PBTransactionsMiddleware {
    static func middlewares() -> [AnyMiddleware] {
        [
            TransactionsMiddleware(),
            TransactionsDetailsMiddleware()
        ]
    }

}
