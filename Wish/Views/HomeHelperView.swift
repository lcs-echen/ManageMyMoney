//
//  HomeHelperView.swift
//  Wish
//
//  Created by Evelyn Chen on 2023-06-08.
//
import Blackbird
import SwiftUI


struct HomeHelperView: View {
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    @State var showingAddWishView = false
    @BlackbirdLiveQuery(tableName: "WishType", { db in try await db.query("SELECT * FROM TypeWithStatistics")}) var types
    @BlackbirdLiveQuery(tableName: "WishCart", { db in try await db.query("SELECT * FROM WishesWithTypeName")}) var history
    @State var searchText = ""
    
    var body: some View {
        ForEach(types.results, id: \.self) { currentType in
            
            NavigationLink(destination: {
                if let typeId = currentType["type_id"]?.intValue,
                   let type = currentType["type"]?.stringValue {
                    WishByTypeView(typeId: typeId, searchText: searchText)
                        .searchable(text: $searchText)

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
    }
}
    
    struct HomeHelperView_Previews: PreviewProvider {
        static var previews: some View {
            HomeHelperView()
        }
    }

