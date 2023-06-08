
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
    @BlackbirdLiveQuery var history: Blackbird.LiveResults<Blackbird.Row>
    
    var body: some View {
        VStack{
            List {
                ForEach(history.results, id: \.self) { history in
                    
                    if  let name = history["name"]?.stringValue,
                        let amount = history["amount"]?.stringValue,
                        let totalCost = history["totalCost"]?.stringValue,
                        let rating = history["rating"]?.intValue,
                        let type = history["type"]?.stringValue {
                        
                        SingleWishResultView(amount: amount, name: name, rating: rating, totalCost: totalCost, type: type)
                        
                    }
                }
//                .onDelete(perform: removeRows)
            }
            
            Spacer()
        }
    }
    
    // MARK: Function
//    func removeRows(at offsets: IndexSet) {
//        Task{
//            if  let id = history["id"]?.intValue {
//
//                try await db!.transaction{ core in
//                    var idList = ""
//                    for offset in offsets{
//                        idList += "\(history.results[offset].id),"
//                    }
//                    print(idList)
//                    idList.removeLast()
//                    print(idList)
//
//                    try core.query("DELETE FROM WishCart WHERE id IN (?)",idList)
//                }
//            }
//        }
//    }
    
    // MARK: Initializers
            init(typeId: Int) {
                
                // Initialize the live query
                _history = BlackbirdLiveQuery(tableName: "WishType", { db in
                    try await db.query("SELECT * FROM WishesWithTypeName WHERE type_id = \(typeId)")
                })
                
                self.typeId = typeId
            }

    
    
}


struct WishByTypeView_Previews: PreviewProvider {
    static var previews: some View {
        WishByTypeView(typeId: 1)
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}

