//
//  TransactionRow.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 13/02/2024.
//

import SwiftUI

struct TransactionRow: View {

    private let transaction: Transaction

    private var price: String {
        let value = transaction.transactionDetail.value
        return "\(value.amount) \(value.currency)"
    }

    private var category: Category {
        Category(id: String(transaction.category))
    }

    init(transaction: Transaction) {
        self.transaction = transaction
    }

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(systemName: "bitcoinsign.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(8)
                .background(Color.cyan)
                .clipShape(Circle())
                .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(transaction.partnerDisplayName)
                        .font(.headline)
                    Spacer()
                    Text(price)
                        .font(.subheadline)
                }
                if let description = transaction.transactionDetail.description {
                    Text(description)
                        .font(.subheadline)
                }
                HStack {
                    if let date = transaction.date {
                        Text(date.formatted(.dateTime))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text(category.title)
                        .font(.caption)
                        .frame(alignment: .trailing)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(.cyan)
                        .clipShape(Capsule())
                }
            }

        }
    }

}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(transaction: Transaction.mock)
            .previewLayout(.sizeThatFits)
    }
}

extension Transaction {
    static let mock = Transaction(partnerDisplayName: "Partner",
                                  category: 1,
                                  transactionDetail: .init(description: "Description",
                                                           bookingDate: "2022-01-22T10:59:05+0200",
                                                           value: .init(amount: 120, currency: "GBP"))
    )
}
