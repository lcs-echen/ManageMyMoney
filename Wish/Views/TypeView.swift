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
    var body: some View {
        NavigationView {
            List {
                Text("Food")
                Text("Drink")
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
    }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
