//
//  ConnectionBanner.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 13/02/2024.
//

import SwiftUI

struct ConnectionBanner: View {

    private let isReachable: Bool
    init(isReachable: Bool) {
        self.isReachable = isReachable
    }

    var body: some View {
        Text("No internet connection")
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .transition(.slide)
    }

}

struct ConnectionBanner_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionBanner(isReachable: false)
            .previewLayout(.sizeThatFits)
    }
}
