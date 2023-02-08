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
        VStack (alignment: .leading){
            Text("Cart")
                .padding(.leading, 30)
                .font(.largeTitle)
                .fontWeight(.bold)
            ScrollView {
                ForEach(history) { history in
                    SingleWishResultView(priorResult: history)
                }
            }
            Spacer()
            HStack{
                Text("Total: ")
                    .fontWeight(.bold)
                    .font(.title)
                Spacer()
                Text("$15")
                    .font(.title)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
            .padding(.top, 20)
            .background(Color.orange)
        }
    }
}


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(history: Binding.constant(wishModelForPreviews))
    }
}
