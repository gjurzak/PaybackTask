//
//  TransactionsView.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import SwiftUI
import ReMVVMCore
import ReMVVMExt

struct TransactionsView: View {

    @ReMVVM.Dispatcher private var dispatcher

    @StateObject var viewModel = TransactionsViewModel()

    var body: some View {

        VStack(spacing: 10) {
            VStack(alignment: .leading) {
                Text("Selected Category: \(viewModel.selectedCategory.title)")
                    .font(.title2)

                Picker("Categories", selection: $viewModel.selectedCategory) {
                    ForEach(viewModel.categories) { category in
                        Text(category.title).tag(category)
                    }
                }
                .pickerStyle(.segmented)

            }
            .padding()

            List {
                Section {
                    ForEach(viewModel.filteredTransactions, id: \.identifier) { transaction in
                        TransactionRow(transaction: transaction)
                            .onTapGesture {
                                let action = PBUIAction.TransactionDetails(transaction: transaction)
                                _dispatcher.dispatch(action: action)
                            }
                    }
                } header: {
                    HStack {
                        Text("TOTAL")
                            .font(.caption)
                        Spacer()
                        Text("\(viewModel.total) PBP")
                            .font(.callout)
                    }
                }

            }
        }
        .overlay {
            if viewModel.inProgress && !viewModel.refreshableInProgress {
                ProgressView()
                    .controlSize(.large)
            }
        }
        .refreshable {
            viewModel.refreshableInProgress = true
            await viewModel.loadTransactions()
        }
        .navigationTitle("Transactions")
        .onAppear {
            Task {
                await viewModel.loadTransactions()
            }
        }
        .alert(isPresented: Binding.constant(viewModel.errorMessage != nil)) {
            let title = Text("Error")
            let message = Text(viewModel.errorMessage ?? "Unknown error")
            let refreshButton = Alert.Button.default(Text("Try again")) {
                viewModel.errorMessage = nil
                Task {
                    await viewModel.loadTransactions()
                }

            }

            let cancelButton = Alert.Button.cancel(Text("Cancel")) {
                viewModel.errorMessage = nil
            }

            return Alert(title: title,
                         message: message,
                         primaryButton: refreshButton,
                         secondaryButton: cancelButton)
        }
    }

}

struct TransactionsView_Previews: PreviewProvider {
    static let transactions = TransactionsViewModel().filteredTransactions
    static var previews: some View {
        Group {
            TransactionsView()
        }
        .previewLayout(.sizeThatFits)
    }
}
