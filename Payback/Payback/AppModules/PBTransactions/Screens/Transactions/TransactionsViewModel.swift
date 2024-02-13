//
//  TransactionsViewModel.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import Combine
import Foundation
import ReMVVMCore

@MainActor
public class TransactionsViewModel: ObservableObject {

    @ReMVVM.State private var state: ApplicationState?

    @Published public var selectedCategory: Category = Category.all
    @Published public var refreshableInProgress: Bool = false
    @Published public var errorMessage: String?

    @Published public private (set) var total = 0
    @Published public private(set) var filteredTransactions: [Transaction] = []
    @Published public private(set) var categories: [Category] = []
    @Published public private(set) var inProgress: Bool = false
    @Published public private(set) var isReachable: Bool = true

    private let transactions = CurrentValueSubject<[Transaction], Never>([])
    private var subscriptions = Set<AnyCancellable>()
    private let transactionsService = TransactionsService()

    public init() {
        setupBinding()
    }

    public func loadTransactions() async {

        errorMessage = nil
        guard !inProgress else { return }

        guard isReachable else {
            let message = "You are offline. Please check your internet connection."
            errorMessage = message
            return
        }

        let result = await transactionsService.fetchTransactions(randomizeSuccess: true,
                                                                 sleepDuration: .seconds(2))
        switch result {
        case .success(let data):
            transactions.value = data
                .sorted { $0.transactionDetail.bookingDate > $1.transactionDetail.bookingDate }
        case .failure(let error):
            errorMessage = error.localizedDescription
            transactions.value = []
        }

    }

    private func setupBinding() {

        transactionsService.$progress.assign(to: &$inProgress)
        transactionsService.$progress.filter { !$0 }.assign(to: &$refreshableInProgress)

        transactions
            .map { $0.map { $0.category } }
            .map { Array(Set($0)).sorted() }
            .removeDuplicates()
            .map { [Category.all] + $0.map { Category(id: String($0)) } }
            .assign(to: &$categories)

        Publishers.CombineLatest(transactions, $selectedCategory)
            .map { transactions, selectedCategory -> [Transaction] in
                guard selectedCategory != Category.all else { return transactions }
                return transactions.filter { String($0.category) == selectedCategory.id }
            }
            .assign(to: &$filteredTransactions)

        $filteredTransactions
            .map { $0.reduce(0, { $0 + $1.transactionDetail.value.amount })}
            .assign(to: &$total)

        $state.map { $0.networkState.isReachable }.assign(to: &$isReachable)

    }

}
