
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
    
    @BlackbirdLiveQuery(tableName: "WishCart", { db in try await db.query("SELECT * FROM TypeWithStatistics")}) var history
    
    var body: some View {
        
        List {
            Text("A")
            Text("B")
            Text("C")
            }
        
            }
//            .onDelete(perform: removeRows)
        }
        
    

    


struct WishByTypeView_Previews: PreviewProvider {
    static var previews: some View {
        WishByTypeView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}

