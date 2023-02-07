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
    var body: some Scene {
        WindowGroup {
            TabView {
                SettingView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Setting")}
                WishesView(history: $history)
                    .tabItem {
                        Image(systemName: "sparkles")
                        Text("Wish")}
                CartView()
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Cart") }
            }
            .accentColor(.green)
        }
    }
}
