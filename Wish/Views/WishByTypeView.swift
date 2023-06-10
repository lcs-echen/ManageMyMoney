
//
//  WishByTypeView.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-04-11.
//

import Blackbird
import SwiftUI

struct WishByTypeView: View {
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    var typeId: Int
    let typeName: String
    @BlackbirdLiveQuery var history: Blackbird.LiveResults<Blackbird.Row>
    @BlackbirdLiveQuery(tableName: "WishType", { db in try await db.query("SELECT * FROM TypeWithStatistics")}) var types

    
    var body: some View {
            VStack{
                List {
                    ForEach(history.results, id: \.self) { history in
                        
                        if  let name = history["name"]?.stringValue,
                            let amount = history["amount"]?.intValue,
                            let totalCost = history["totalCost"]?.doubleValue,
                            let rating = history["rating"]?.intValue,
                            let type = history["type"]?.stringValue {
                            
                            SingleWishResultView(amount: amount, name: name, rating: rating, totalCost: totalCost, type: type)
                            
                        }
                    }
                    .onDelete(perform: removeRows)
                }
                
                Spacer()

        }
        .navigationTitle(typeName)
    }

    // MARK: Function
    func removeRows(at offsets: IndexSet) {
        Task {
            try await db!.transaction{ core in
            var idList = ""
            for offset in offsets{
                if let id = history.results[offset]["id"]?.intValue {
                    idList += "\(id),"
                }
            }
            print(idList)
            idList.removeLast()
            print(idList)

            try core.query("DELETE FROM WishCart WHERE id IN (?)",idList)
        }
            
        }
    }
    
    // MARK: Initializers
    init(typeId: Int, searchText: String, typeName: String) {
            
            // Initialize the live query
            _history = BlackbirdLiveQuery(tableName: "WishType", { db in
                try await db.query("SELECT * FROM WishesWithTypeName WHERE type_id = \(typeId) and name LIKE '%\(searchText)%' ")
            })
            
            self.typeId = typeId
            self.typeName = typeName
        }

    
    
}


struct WishByTypeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            WishByTypeView(typeId: 1, searchText: "", typeName: "Car")
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
        
    }
}

