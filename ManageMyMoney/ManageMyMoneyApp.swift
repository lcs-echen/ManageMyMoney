//
//  ManageMyMoneyApp.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-05.
//

import SwiftUI

@main
struct ManageMyMoneyApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                SettingView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Setting")}
                WishesView()
                    .tabItem {
                        Image(systemName: "sparkles")
                        Text("Wish")}
                CartView()
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Calcuation") }
            }
            .accentColor(.green)
        }
    }
}
