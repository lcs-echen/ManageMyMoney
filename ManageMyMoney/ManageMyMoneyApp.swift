//
//  ManageMyMoneyApp.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-05.
//

import SwiftUI

@main
struct ManageMyMoneyApp: App {
    @State var history: [Wishes] = []
    @State var totalSpending: Double = 0
    var body: some Scene {
        WindowGroup {
            TabView {
                SettingView(totalSpending: $totalSpending)
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Setting")}
                WishesView(history: $history)
                    .tabItem {
                        Image(systemName: "sparkles")
                        Text("Wish")}
                CartView(totalSpending: $totalSpending, history: $history)
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Cart") }
            }
            .accentColor(.orange)
        }
    }
}
