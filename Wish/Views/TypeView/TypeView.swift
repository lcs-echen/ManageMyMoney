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
                List(wishType.results) { currentType in
                    Text(currentType.type)
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
        .accentColor(.orange)
    }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
