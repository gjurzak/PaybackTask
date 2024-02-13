//
//  PBUIActions.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import Foundation
import ReMVVMCore
import ReMVVMExt

enum PBUIAction {

    enum Transactions: StoreAction { case show }
    struct TransactionDetails: StoreAction {
        let transaction: Transaction
    }

}
