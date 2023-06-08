//
//  TypeView.swift
//  Wish
//
//  Created by Evelyn Chen on 2023-06-06.
//

import SwiftUI
import Blackbird

struct TypeView: View {
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    @State var showingAddTypeView = false
    @BlackbirdLiveModels({db in
        try await WishType.read(from: db)
    }) var wishType
    var body: some View {
        NavigationView {
            VStack{
                List{
                    ForEach(wishType.results) { currentType in
                        Text(currentType.type)
                    }
                    .onDelete(perform: removeRows)
                }
            }
            
            .navigationTitle("Types")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingAddTypeView = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $showingAddTypeView) {
                        AddTypeView()
                            .presentationDetents([.fraction(0.2)])
                    }

                }
            }
        }
        .accentColor(Color("Orange"))
    }
        func removeRows(at offsets: IndexSet) {
            Task{
    
                    try await db!.transaction{ core in
                        var idList = ""
                        for offset in offsets{
                            idList += "\(wishType.results[offset].id),"
                        }
                        print(idList)
                        idList.removeLast()
                        print(idList)
    
                        try core.query("DELETE FROM WishCart WHERE id IN (?)",idList)
                    }
            }
        }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
