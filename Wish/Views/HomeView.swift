//
//  HomeView.swift
//  Wish
//
//  Created by Evelyn Chen on 2023-06-03.
//

import SwiftUI
import Blackbird

struct HomeView: View {
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    @State var showingAddWishView = false
    @BlackbirdLiveQuery(tableName: "WishCart", { db in try await db.query("SELECT * FROM TypeWithStatistics")}) var types
    @BlackbirdLiveQuery(tableName: "WishCart", { db in try await db.query("SELECT * FROM WishesWithTypeName")}) var history
    @State var totalSpending: Double = 0
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(types.results, id: \.self) { currentType in
                        
                        Section(content: {
                            if let typeId = currentType["type_id"]?.intValue {
                                WishByTypeView(typeId: typeId)
                            }
                        }, header: {
                            if let typeName = currentType["type"]?.stringValue,
                               let wishCount = currentType["type_count"]?.intValue,
                               let wishCostSum = currentType["cost_sum"]?.doubleValue?.formatted()
                            {
                                HStack {
                                    Text(typeName)
                                    Spacer()
                                    Text("\(wishCount) wishes / $\(wishCostSum)total")
                                }
                            }
                        })
                        
                    }
                }
                .listStyle(.grouped)
                .navigationTitle("My Wish")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            showingAddWishView = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                        .sheet(isPresented: $showingAddWishView) {
                            WishesView()
                                .presentationDetents([.fraction(0.65)])
                        }
                        
                    }
                }
                
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
                    for result in history.results {
                        if let totalCost = result["totalCost"]?.stringValue,
                           let nextValue = try? Double(totalCost, format: .currency(code: "CAD")) {
                            total += nextValue
                        }
                    }
                    // Update the view
                    totalSpending = total
                }
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
