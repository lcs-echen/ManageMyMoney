//
//  HomeView.swift
//  Wish
//
//  Created by Evelyn Chen on 2023-06-03.
//

import SwiftUI
import Blackbird

struct HomeView: View {
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    @State var showingAddWishView = false
    var body: some View {
        NavigationView {
            List {
                Text("Food")
                Text("Drink")
            }
            .navigationTitle("My Wish")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingAddWishView = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $showingAddWishView) {
                        WishesView()
                            .presentationDetents([.fraction(0.6)])
                    }

                }
            }
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
