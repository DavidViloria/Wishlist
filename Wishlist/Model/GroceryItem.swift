//
//  Item.swift
//  Wishlist
//
//  Created by David Viloria Ortega on 24/05/25.
//

import Foundation
import SwiftData


@Model
class GroceryItem{
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool) {
        self.title = title
        self.isCompleted = isCompleted
    }
}
