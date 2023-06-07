
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
            
        }
        
        
    }
    
    // MARK: Initializers
            init(typeId: Int) {
                
                // Initialize the live query
                _history = BlackbirdLiveQuery(tableName: "WishType", { db in
                    try await db.query("SELECT * FROM WishesWithTypeNames WHERE type_id = \(typeId)")
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

