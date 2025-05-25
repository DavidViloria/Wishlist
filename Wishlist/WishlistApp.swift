//
//  WishlistApp.swift
//  Wishlist
//
//  Created by David Viloria Ortega on 22/05/25.
//

import SwiftUI
import SwiftData

@main
struct WishlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: GroceryItem.self)
        }
    }
}
