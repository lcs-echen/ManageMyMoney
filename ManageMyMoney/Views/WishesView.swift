//
//  WishesView.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-05.
//

import SwiftUI

struct WishesView: View {
    @State var wish: String = ""
    @State var cost: String = ""
    @State var amount: Double = 1
    
    var costAsOptionalDouble: Double? {
        guard let cost = Double(cost) else {
            return nil
        }
        return cost
    }
    var totalCost: String {
        guard let cost = costAsOptionalDouble else {
            return "Please provide a solid numeric value for estimated cost."
        }
        let totalCost = cost * amount
        return "$" + totalCost.formatted(.number.precision(.fractionLength(1)))
    }
    var body: some View {
        HStack {
            VStack (alignment: .leading){
                Text("Wishes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 15)
                Group{
                    Text("Your Wish: ")
                        .font(.title2)
                    TextField("Please enter your wish", text: Binding.constant(""))
                        .padding(.bottom, 10)
                }
                Group {
                    Text("Estimated cost? ")
                        .font(.title2)
                    TextField("Please enter the estimated cost", text: $cost)
                        .padding(.bottom, 10)
                }
                Group{
                    Text("Amount/Times")
                        .font(.title2)
                    Stepper("\(amount.formatted(.number.precision(.fractionLength(0))))", value: $amount, in: 1...100)
                        .padding(.bottom, 15)
                }
                HStack {
                    Text("Total Cost: ")
                        .font(.title2)
                    Spacer()
                    Text(totalCost)
                        .font(.title2)
                        .multilineTextAlignment(.trailing)
                }
                Spacer()
            }
            .padding()
            Spacer()
        }
        
    }
}

struct WishesView_Previews: PreviewProvider {
    static var previews: some View {
 
            WishesView()

    }
}
