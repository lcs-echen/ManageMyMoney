//
//  WishesView.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-05.
//

import SwiftUI

struct WishesView: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading){
                Group{
                    Text("Your Wish: ")
                        .font(.title2)
                    TextField("Please enter your wish", text: Binding.constant(""))
                        .padding(.bottom, 10)
                }
                Group {
                    Text("Estimated cost? ")
                        .font(.title2)
                    TextField("Please enter the estimated cost", text: Binding.constant(""))
                        .padding(.bottom, 10)
                }
                Group{
                    Text("Amount/Times")
                        .font(.title2)
                    Stepper("2", value: Binding.constant(2), in: 0...20)
                        .padding(.bottom, 15)
                }

                HStack {
                    Text("Total Cost: ")
                        .font(.title2)
                    Spacer()
                    Text("$450")
                        .font(.title2)
                }
                Spacer()
            }
            .padding()
            Spacer()
        }
        .navigationTitle("WISHES")
    }
}

struct WishesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WishesView()
        }
    }
}