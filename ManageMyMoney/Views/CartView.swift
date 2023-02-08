//
//  CartView.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-05.
//

import SwiftUI


struct CartView: View {
    
    @Binding var totalSpending: Double
    @Binding var history: [Wishes]
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Cart")
                .padding(.leading, 30)
                .font(.largeTitle)
                .fontWeight(.bold)
            List {
                ForEach(history) { history in
                    SingleWishResultView(priorResult: history)
                }
                .onDelete { offsets in
                    history.remove(atOffsets: offsets)
                }
            }
            Spacer()
            HStack{
                Text("Total: ")
                    .fontWeight(.semibold)
                    .font(.title)
                Spacer()
                Text("$\(totalSpending.formatted(.number.precision(.fractionLength(2))))")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
            .padding(.top, 20)
            
        }
        .onAppear {
            // Create a running total that is zero
            var total = 0.0
            // Iterate over each item and add to the running total
            for item in history {
                total += Double(item.cost) ?? 0
            }
            // Update the view
            totalSpending = total
        }
    }
}


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(totalSpending: Binding.constant(325.00), history: Binding.constant(wishModelForPreviews))
    }
}
