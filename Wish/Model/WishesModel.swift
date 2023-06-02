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
    @BlackbirdColumn var completed: Bool
}


