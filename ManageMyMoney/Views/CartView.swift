//
//  CartView.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-05.
//

import SwiftUI

struct CartView: View {
    @Binding var history: [Wishes]
    var body: some View {
        VStack {
            Text("Cart")
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(history: Binding.constant(wishModelForPreviews))
    }
}
