//
//  WishesModel.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-05.
//

import Foundation

struct Wishes: Identifiable {
    let id = UUID()
    let name: String
    let cost: String
    let amount: String
}
let wish1 = Wishes(name: "Hat", cost: "10", amount: "2")
let wish2 = Wishes(name: "Sun Glasses", cost: "5", amount: "4")

let wishModelForPreviews = [wish1, wish2]
    

