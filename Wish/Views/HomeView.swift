//
//  HomeView.swift
//  Wish
//
//  Created by Evelyn Chen on 2023-06-03.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Food")
                Text("Drink")
            }
        }
        .navigationTitle("My Wish")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
