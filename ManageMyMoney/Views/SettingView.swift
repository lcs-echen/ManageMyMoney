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
    
    // MARK: Computed Properties
    var cashAsOptionalDouble: Double? {
        guard let cash = Double(cash) else {
            return nil
        }
        return cash
    }
    var expensesPercentage: Double {
        return saving + entertainment + expense1 + expense2 + expense3
    }
    var left: String {
        guard let cashAsDouble = cashAsOptionalDouble else {
            return "Please provide a solid numeric value"
        }
        let result = cashAsDouble * (1 - expensesPercentage/100)
        return "$" + result.formatted(.number.precision(.fractionLength(1)))
    }
    // Interface
    var body: some View {
        VStack (alignment: .leading){
            Text("Manage My Money")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 15)
            VStack (alignment: .leading){
                Text("Cash on hand")
                    .font(.title)
                HStack {
                    Text("$")
                    TextField("Enter a numeric value", text: $cash)
                }
                .padding(.bottom, 5)
            }
            HStack {
                Text("Expenses")
                    .font(.title)
                Spacer()
                Text("\(expensesPercentage.formatted(.number.precision(.fractionLength(1))))")
                    .font(.title)
                + Text("%")
                    .font(.title2)
            }
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

                    Text(left)
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
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingView()
        }
    }
}
