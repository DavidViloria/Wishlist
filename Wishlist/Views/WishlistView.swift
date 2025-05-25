//
//  Wishlist.swift
//  Wishlist
//
//  Created by David Viloria Ortega on 22/05/25.
//

import SwiftUI
import SwiftData

struct Wishlist: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wishes: [WishlistModel]
    
    
    @State private var isAlerShowing: Bool = false
    @State private var title: String = ""
    var body: some View {
        NavigationStack{
            List{
                ForEach(wishes) { wish in
                    Text(wish.title)
                        .font(.title2.weight(.medium))
                        .padding(.vertical, 2)
                        .frame(alignment: .center)
                        .swipeActions {
                            Button("Delete", role: .destructive){
                                modelContext.delete(wish)
                            }
                        }
                    
                }
            }
            .navigationTitle("Wishlits")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAlerShowing.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                    
                }
                
                if wishes.isEmpty == false{
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(wishes.count)")
                    }
                }
            })
            .alert("Agregar lista de deseos", isPresented: $isAlerShowing) {
                TextField("Tittle", text: $title)
                
                Button{
                    modelContext.insert(WishlistModel(title: title))
                    title = ""
                } label:{
                    Text("Save")
                }
                
            }
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

#Preview {
    Wishlist()
        .modelContainer(for: WishlistModel.self, inMemory: true)
}
