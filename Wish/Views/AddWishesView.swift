//
//  AddWishesView.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-05.
//
import Blackbird
import SwiftUI

struct AddWishesView: View {
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    @State var name: String = ""
    @State var cost: String = ""
    @State var amount: Double = 1
    @State var type_id = 1
    @State var rating: Int = 3
    @BlackbirdLiveQuery(tableName: "WishCart", { db in try await db.query("SELECT * FROM WishesWithTypeName")}) var history
    @BlackbirdLiveModels({db in
        try await WishType.read(from: db)
    }) var wishType
    
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
        
        NavigationView {
            VStack (alignment: .leading){
                Group{
                    Text("Your Wish: ")
                        .font(.title2)
                    TextField("Please enter your wish", text: $name)
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
                HStack{
                    Text("Type: ")
                        .font(.title2)
                    Picker(selection: $type_id,
                           label:Text("Select a type"),
                           content: {

                            ForEach(wishType.results) { currentType in
                                Text(currentType.type).tag(currentType.id)
                                }
                    })

                }
                
                Picker(selection: $rating,
                           label: Text("Picker Name"),
                           content: {
                        Text("❤️").tag(1)
                        Text("❤️❤️").tag(2)
                        Text("❤️❤️❤️").tag(3)
                        Text("❤️❤️❤️❤️").tag(4)
                    })
                    .pickerStyle(.segmented)
                
                HStack {
                    Text("Total Cost: ")
                        .font(.title2)
                    Spacer()
                    Text(totalCost)
                        .font(.title2)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.top, 5)
                Spacer()
            }
            .padding()
            .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Button(action: {
                                    addWish()
                                }, label: {
                                    Text("Add")
                                })
                                .disabled(costAsOptionalDouble == nil)
                                .disabled(name == "")
                            }
                        }
        }
        .accentColor(Color("Orange"))
        
    }

    
    //MARK: Function
    func addWish() {
        Task {
            try await db!.transaction { core in
                try core.query("""
                            INSERT INTO WishCart (
                            name,
                            totalCost,
                            amount,
                            type_id,
                            rating
                            )
                            VALUES (
                                (?),
                                (?),
                                (?),
                                (?),
                                (?)
                            )
                            """,
                            name,
                            totalCost,
                            amount,
                            type_id,
                            rating)
            }
            // Reset input fields after writing to database
            name = ""
            cost = ""
            type_id = 1
            rating = 3
            amount = 1
        }
    }
}

struct AddWishesView_Previews: PreviewProvider {
    static var previews: some View {
 
        AddWishesView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
