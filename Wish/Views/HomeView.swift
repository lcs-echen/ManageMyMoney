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
    var body: some View {
        NavigationView {
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
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
