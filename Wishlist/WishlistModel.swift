//
//  SwiftDataModel.swift
//  Wishlist
//
//  Created by David Viloria Ortega on 23/05/25.
//

import Foundation
import SwiftData

@Model
class WishlistModel {
    var title : String
    
    init(title: String) {
        self.title = title
    }
}
