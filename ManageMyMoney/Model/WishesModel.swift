//
//  WishesModel.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-05.
//

import Foundation

struct Wishes: Identifiable {
    let id: Int
    let name: String
    let totalCost: String
    let amount: String
    let completed: Bool
}
let wish1 = Wishes(id: 1, name: "Hat", totalCost: "10", amount: "2", completed: false)
let wish2 = Wishes(id: 2, name: "Sun Glasses", totalCost: "5", amount: "4", completed: false)

let wishModelForPreviews = [wish1, wish2]
    

