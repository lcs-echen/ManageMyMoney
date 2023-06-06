//
//  Type.swift
//  Wish
//
//  Created by Evelyn Chen on 2023-06-06.
//

import Foundation
import Blackbird

struct Type: BlackbirdModel {
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var type: String
}
