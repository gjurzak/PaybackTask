//
//  StoreActions.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import Foundation
import ReMVVMCore

enum PBStoreAction {

    enum Network: StoreAction {
        case clear
        case isReachable(Bool)
    }

}
