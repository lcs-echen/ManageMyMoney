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

    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "sparkles")
                        Text("Wish")}

                TypeView()
                    .tabItem {
                        Image(systemName: "sparkles")
                        Text("Wish")}
                    
            }
            .environment(\.blackbirdDatabase, AppDatabase.instance)
            .accentColor(Color("Orange"))
        }
    }
}
