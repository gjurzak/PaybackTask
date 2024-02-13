//
//  TransactionDetailsViewModel.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import Combine
import Foundation

class TransactionDetailsViewModel: ObservableObject {

    @Published private(set) var transaction: Transaction

    init(transaction: Transaction) {
        self.transaction = transaction
    }

}
