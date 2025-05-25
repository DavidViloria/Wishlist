//
//  ContentView.swift
//  Wishlist
//
//  Created by David Viloria Ortega on 22/05/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wishes: [WishlistModel]
    
    
    @State private var isAlerShowing: Bool = false
    @State private var title: String = ""
    var body: some View {
        TabView{
            Wishlist()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Inicio")
                }
            
            GroceryList()
                .tabItem {
                    Image(systemName: "storefront")
                    Text("Grocery")
                }
        }
    }
}
#Preview("ContentView") {
    ContentView()
        .modelContainer(for: WishlistModel.self, inMemory: true)
}

