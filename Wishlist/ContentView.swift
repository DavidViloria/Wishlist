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
    var body: some View {
        NavigationStack{
            List{
                ForEach(wishes) { wish in
                    Text(wish.title)
                        .font(.title2.weight(.medium))
                        .padding(.vertical, 2)
                        .frame(alignment: .center)
                        
                }
            }
            .navigationTitle("Wishlits")
            .overlay {
                if wishes.isEmpty{
                    ContentUnavailableView(
                        "Sin deseos todavía",
                        systemImage: "star.slash",
                        description: Text("Pulsa “＋” para añadir tu primer deseo")
                    )
                }
            }
            
        }
    }
}
#Preview("ContentView") {
    let container = try! ModelContainer(for: WishlistModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    container.mainContext.insert(WishlistModel(title: "Mi primer deseo"))
    container.mainContext.insert(WishlistModel(title: "Mi segundo deseo"))
    container.mainContext.insert(WishlistModel(title: "Viajar a Europa"))
    container.mainContext.insert(WishlistModel(title: "Descubrir America"))
    return ContentView()
        .modelContainer(container)
}
#Preview("EmptyList") {
    ContentView()
        .modelContainer(for: WishlistModel.self, inMemory: true)
}
