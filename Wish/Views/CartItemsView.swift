//
//  CartItemsView.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-04-11.
//

import Blackbird
import SwiftUI

struct CartItemsView: View {
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    @BlackbirdLiveQuery(tableName: "WishCart", { db in try await db.query("SELECT * FROM WishesWithTypeName")}) var history
    
    var body: some View {
        
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
        
                
//                Label(title: {
//
//                    SingleWishResultView(amount: amount, name: name, rating: rating, totalCost: totalCost)
//                }, icon: {
//                    if history.completed == true {
//                        Image(systemName: "checkmark.circle")
//                    } else {
//                        Image(systemName: "circle")
//                    }
//                })}
//                .onTapGesture {
//                    Task {
//                        try await db!.transaction {
//                            core in try core.query("UPDATE WishCart SET completed = (?) WHERE id = (?)", !history.completed, history.id)
//                        }
//                    }
//                }
            }
//            .onDelete(perform: removeRows)
        }
        
    
//    init(filteredOn searchText: String){
//        _history = BlackbirdLiveModels({
//            db in
//            try await WishCart.read(from: db, sqlWhere: "name LIKE ?", "%\(searchText)%")
//        })
//    }
//
//
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
    
}

struct CartItemsView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemsView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}

