//
//  CartView.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-05.
//
import Blackbird
import SwiftUI


struct CartView: View {
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    @Binding var totalSpending: Double
    @State var searchText = ""
    @BlackbirdLiveModels({ db in try await WishCart.read(from: db)}) var history
    var body: some View {
        NavigationView {
            VStack (alignment: .leading){

                CartItemsView(filteredOn: searchText)
                    .searchable(text: $searchText)
                
                
                Spacer()
                HStack {
                    Text("Total: ")
                        .fontWeight(.semibold)
                        .font(.title)
                    Spacer()
                    Text("$")
                        .foregroundColor(Color("Orange"))
                        .font(.title)
                        .fontWeight(.semibold)
                    + Text ("\(totalSpending.formatted(.number.precision(.fractionLength(2))))")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Orange"))
                    
                }
                .padding(.horizontal, 30)
                .padding(.top, 8)
                .padding(.bottom, 25)
                .onAppear {
                    // Create a running total that is zero
                    var total = 0.0
                    // Iterate over each item and add to the running total
                    for item in history.results {
                        if let nextValue = try? Double(item.totalCost, format: .currency(code: "CAD")) {
                            total += nextValue
                        }
                    }
                    // Update the view
                    totalSpending = total
                }
                
            }
            .navigationTitle("Cart")
            
        }
        
    }
}
    
    
    struct CartView_Previews: PreviewProvider {
        static var previews: some View {
            CartView(totalSpending: Binding.constant(325.00))
        }
    }

