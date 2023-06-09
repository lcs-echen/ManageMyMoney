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
    @BlackbirdLiveQuery(tableName: "WishType", { db in try await db.query("SELECT * FROM TypeWithStatistics")}) var types
    @BlackbirdLiveQuery(tableName: "WishCart", { db in try await db.query("SELECT * FROM WishesWithTypeName")}) var history
    @State var totalSpending: Double = 0
    @State var searchText = ""
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(types.results, id: \.self) { currentType in
                        
                        NavigationLink(destination: {
                            if let typeId = currentType["type_id"]?.intValue,
                               let type = currentType["type"]?.stringValue
                            {

                                    WishByTypeView(typeId: typeId, searchText: searchText, typeName: type)
                                        .searchable(text: $searchText)
    
                            } else {
                                Text("No value found.")
                            }
                        }, label: {
                            if let typeName = currentType["type"]?.stringValue,
                               let wishCount = currentType["type_count"]?.intValue,
                               let wishCostSum = currentType["cost_sum"]?.doubleValue?.formatted()
                            {
                                SingleTypeView(typeName: typeName, wishCount: wishCount, wishCostSum: wishCostSum)
                            }
                        })
                        
                    }
                    NavigationLink(destination: {
                        TypeView()
                    }, label: {
                        Text("Edit my wish types")
                            .padding(.vertical)
                            .foregroundColor(Color("Orange"))
                            .fontWeight(.semibold)
                    })
                    
                }
                .listStyle(.automatic)
                .navigationTitle("My Wish")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            showingAddWishView = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                        .sheet(isPresented: $showingAddWishView) {
                            AddWishesView()
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
            .accentColor(Color("Orange"))
        }
        
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
        
    }
}
