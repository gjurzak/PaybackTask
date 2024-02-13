//
//  TransactionsServiceTests.swift
//  PaybackTests
//
//  Created by Grzegorz Jurzak on 13/02/2024.
//

import XCTest
@testable import Payback

@MainActor
final class TransactionsServiceTests: XCTestCase {

    var transactionsService: TransactionsService!

    override func setUp() {
        super.setUp()
        transactionsService = TransactionsService()
    }

    func testFetchTransactionsSuccess() async {
        let result = await transactionsService.fetchTransactions()
        XCTAssertNotNil(result)
        switch result {
        case .success(let transactions):
            XCTAssertFalse(transactions.isEmpty)
        default:
            XCTFail("Expected success but got failure")
        }
    }

}
