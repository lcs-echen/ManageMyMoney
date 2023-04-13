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
    
    @BlackbirdLiveModels var history: Blackbird.LiveResults<WishCart>
    
    var body: some View {
        List {
            ForEach(history.results) { history in
                Label(title: {
                    SingleWishResultView(priorResult: history)
                }, icon: {
                    if history.completed == true {
                        Image(systemName: "checkmark.circle")
                    } else {
                        Image(systemName: "circle")
                    }
                })
                .onTapGesture {
                    Task {
                        try await db!.transaction {
                            core in try core.query("UPDATE WishCart SET completed = (?) WHERE id = (?)", !history.completed, history.id)
                        }
                    }
                }
            }
            .onDelete(perform: removeRows)
        }
        }
    
    init(filteredOn searchText: String){
        _history = BlackbirdLiveModels({
            db in
            try await WishCart.read(from: db, sqlWhere: "name LIKE ?", "%\(searchText)%")
        })
    }
    
    
    func removeRows(at offsets: IndexSet) {
        Task{
            
            try await db!.transaction{ core in
                var idList = ""
                for offset in offsets{
                    idList += "\(history.results[offset].id),"
                }
                print(idList)
                idList.removeLast()
                print(idList)
                
                try core.query("DELETE FROM WishCart WHERE id IN (?)",idList)
            }
            
        }
    }
    
}

struct CartItemsView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemsView(filteredOn: "")
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}

