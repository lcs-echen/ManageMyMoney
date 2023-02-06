//
//  SettingView.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-05.
//

import SwiftUI

struct SettingView: View {
    // MARK: Stored Properties
    @State var saving: Double = 5
    @State var entertainment: Double = 5
    @State var expense1: Double = 5
    @State var expense2: Double = 5
    @State var expense3: Double = 5
    @State var cash: String = ""
    var cashAsOptionalDouble: Double? {
        guard let cash = Double(cash) else {
            return nil
        }
        return cash
    }
    // MARK: Computed Properties
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
                    Text("Saving               ")
                        .font(.title3)
                    Slider(value: $saving,
                           in: 0...100)
                    Text("\(saving.formatted(.number.precision(.fractionLength(1))))")
                        .font(.title3)
                    + Text("%")
                        .font(.title3)
                }
                HStack {
                    Text("Entertainment  ")
                        .font(.title3)
                    Slider(value: $entertainment,
                           in: 0...100)
                    Text("\(entertainment.formatted(.number.precision(.fractionLength(1))))")
                        .font(.title3)
                    + Text("%")
                        .font(.title3)
                }
                HStack {
                    TextField("Enter your own", text: Binding.constant(""))
                        .font(.title3)
                    Slider(value: $expense1,
                           in: 0...100)
                    Text("\(expense1.formatted(.number.precision(.fractionLength(1))))")
                        .font(.title3)
                    + Text("%")
                        .font(.title3)
                }
                HStack {
                    TextField("Enter your own", text: Binding.constant(""))
                        .font(.title3)
                    Slider(value: $expense2,
                           in: 0...100)
                    Text("\(expense2.formatted(.number.precision(.fractionLength(1))))")
                        .font(.title3)
                    + Text("%")
                        .font(.title3)
                }
                HStack {
                    TextField("Enter your own", text: Binding.constant(""))
                        .font(.title3)
                    Slider(value: $expense3,
                           in: 0...100)
                    Text("\(expense3.formatted(.number.precision(.fractionLength(1))))")
                        .font(.title3)
                    + Text("%")
                        .font(.title3)
                }
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
