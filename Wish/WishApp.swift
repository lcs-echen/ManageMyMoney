//
//  WishApp.swift
//  Wish
//
//  Created by Evelyn Chen on 2023-02-05.
//

import SwiftUI
import Blackbird
@main
struct WishApp: App {

    @State var totalSpending: Double = 0
    var body: some Scene {
        WindowGroup {
            TabView {
                WishesView()
                    .tabItem {
                        Image(systemName: "sparkles")
                        Text("Wish")}
                CartView(totalSpending: $totalSpending)
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Cart") }
                    
            }
            .environment(\.blackbirdDatabase, AppDatabase.instance)
            .accentColor(Color("Orange"))
        }
    }
}
