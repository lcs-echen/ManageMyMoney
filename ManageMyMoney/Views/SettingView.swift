//
//  SettingView.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-05.
//

import SwiftUI

struct SettingView: View {
    @State var saving: Double = 5
    var body: some View {
        VStack (alignment: .leading){

            HStack{
                Text("Cash on hand")
                    .font(.title)
                Text("$")
                TextField("Enter a numeric value", text: Binding.constant(""))
            }
            Text("Expenses")
                .font(.title)
            VStack (alignment: .leading){
                HStack {
                    Text("Saving              ")
                        .font(.title3)
                    Slider(value: $saving,
                           in: 0...100)
                    Text("\(saving.formatted(.number.precision(.fractionLength(1))))")
                        .font(.title3)
                    + Text("%")
                        .font(.title3)
                }
                Text("Entertainment")
                    .font(.title3)
            }
            .padding()
            
            HStack{
                VStack {
                    Text("Left")
                        .font(.title)
                    Text("$")
                        .font(.title2)
                    + Text("450")
                        .font(.title2)
                }
                .padding(.leading, 30)
                Spacer()
                VStack {
                    Text("Wish")
                        .font(.title)
                    Text("$")
                        .font(.title2)
                    + Text("450")
                        .font(.title2)
                }
                .padding(.trailing, 30)
                
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Manage My Money")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingView()
        }
    }
}
