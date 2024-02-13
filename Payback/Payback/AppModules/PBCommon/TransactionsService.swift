//
//  TransactionsService.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 13/02/2024.
//

import Foundation

struct TransactionContainer: Codable {
    let items: [Transaction]
}

public struct Transaction: Codable {

    public let identifier = UUID()
    public let partnerDisplayName: String
    public let category: Int
    public let transactionDetail: TransactionDetail

    public struct TransactionDetail: Codable {
        public var description: String?
        public let bookingDate: String // Consider converting to Date using a DateFormatter if needed
        public let value: TransactionValue
        public init(description: String? = nil, bookingDate: String, value: TransactionValue) {
            self.description = description
            self.bookingDate = bookingDate
            self.value = value
        }
    }

    public struct TransactionValue: Codable {
        public let amount: Int
        public let currency: String
        public init(amount: Int, currency: String) {
            self.amount = amount
            self.currency = currency
        }
    }

    public var date: Date? {
        DateFormatter.iso8601Full.date(from: transactionDetail.bookingDate)
    }

    public init(partnerDisplayName: String, category: Int, transactionDetail: TransactionDetail) {
        self.partnerDisplayName = partnerDisplayName
        self.category = category
        self.transactionDetail = transactionDetail
    }
}

public struct Category: Equatable, Hashable, Identifiable {

    static var all: Category { Category(id: kAllKey) }

    public var title: String {
        if id == Category.kAllKey { return "All" }
        return id
    }
    public var tag: String { "cat_\(id)" }
    public let id: String

    public init(id: String) {
        self.id = id
    }

    private static let kAllKey = "all"

}

@MainActor
public class TransactionsService {

    @Published public private(set) var progress: Bool = false

    public func fetchTransactions(randomizeSuccess: Bool = false,
                                  sleepDuration: Duration = .zero) async -> Result<[Transaction], Error> {
        progress = true

        defer { progress = false }

        do {
            try await Task.sleep(for: sleepDuration)

            let success = randomizeSuccess ? Bool.random() : true

            if success {
                guard
                    let path = Bundle.main.path(forResource: "PBTransactions", ofType: "json"),
                    let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
                    let container = try? JSONDecoder().decode(TransactionContainer.self, from: data)
                else {
                    return .failure(NSError(domain: "pl.mobigreg.error",
                                            code: 404,
                                            userInfo: [NSLocalizedDescriptionKey: "No result found"]))
                }
                return .success(container.items)
            } else {
                return .failure(NSError(domain: "pl.mobigreg.error",
                                        code: 404,
                                        userInfo: [NSLocalizedDescriptionKey: "No result found"]))
            }
        } catch {
            return .failure(error)
        }
    }
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
