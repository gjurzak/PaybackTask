//
//  TransactionDetailsView.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import SwiftUI

struct TransactionDetailsView: View {

    @ObservedObject var viewModel: TransactionDetailsViewModel

    init(viewModel: TransactionDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            TransactionRow(transaction: viewModel.transaction)
            Spacer()
        }
        .padding()
        .navigationTitle("Transaction")
    }
}

struct TransactionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailsView(viewModel: .init(transaction: .mock))
    }
}
