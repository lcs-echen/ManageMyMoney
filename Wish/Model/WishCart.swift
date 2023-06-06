//
//  WishesModel.swift
//  ManageMyMoney
//
//  Created by Evelyn Chen on 2023-02-05.
//
import Blackbird
import Foundation

struct WishCart: BlackbirdModel {
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var name: String
    @BlackbirdColumn var totalCost: String
    @BlackbirdColumn var amount: String
    @BlackbirdColumn var type_id: Int
    @BlackbirdColumn var rating: Int
    @BlackbirdColumn var completed: Bool
}

let wish1 = WishCart(id: 2, name: "Apple", totalCost: "100.00", amount: "20", type_id: 3, rating: 4, completed: false)
