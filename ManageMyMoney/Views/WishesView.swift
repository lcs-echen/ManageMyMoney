//
//  WishesView.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-05.
//
import Blackbird
import SwiftUI

struct WishesView: View {
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    @State var wish: String = ""
    @State var cost: String = ""
    @State var amount: Double = 1
    @BlackbirdLiveModels({ db in try await Wishes.read(from: db)}) var history
    var costAsOptionalDouble: Double? {
        guard let cost = Double(cost) else {
            return nil
        }
        guard cost > 0 else {
            return nil
        }
        return cost
    }
    var totalCost: String {
        guard let cost = costAsOptionalDouble else {
            return "Please return a positive numeric value for the estimated cost"
        }
        
        let totalCost = cost * amount
        return totalCost.formatted(.number.precision(.fractionLength(2)))
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
                    TextField("Please enter your wish", text: $wish)
                        .padding(.bottom, 10)
                }
                Group {
                    Text("Estimated cost? ")
                        .font(.title2)
                    HStack (alignment: .top) {
                        Text("$")
                        TextField("Please enter the estimated cost", text: $cost)
                            .padding(.bottom, 10)
                    }
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
                .padding(.top, 5)
                HStack {
                    Spacer()
                    Button(action: {
//                        let lastId = history.last!.id
//                        let newId = lastId + 1
//                        let amount1 = String(amount.formatted(.number.precision(.fractionLength(0))))
//
//                        // Create the prior result, all put together into an instance of Result
//                        let newWishItem = Wishes(id: newId, name: wish, totalCost: totalCost, amount: amount1, completed: false)
//
//                        // Save the prior result to the history
//                        history.append(newWishItem)
//

                        Task {
                            try await db!.transaction {
                                core in try core.query("INSERT INTO WishCart (name, totalCost, amount) VALUES (?,?,?)", wish, totalCost, amount)
                            }
                            
                            wish = ""
                            cost = ""
                            amount = 1
                        }
                    }, label: {
                        Text("Add to Cart")
                            .font(.headline.smallCaps())
                    })
                    .buttonStyle(.bordered)
                    .disabled(costAsOptionalDouble == nil)
                    .disabled(wish == "")
                    
                    Spacer()
                }
                .padding(.top, 30)
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
