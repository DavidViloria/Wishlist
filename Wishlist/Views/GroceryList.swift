//
//  GroceryList.swift
//  Wishlist
//
//  Created by David Viloria Ortega on 24/05/25.
//

import SwiftUI
import SwiftData

struct GroceryList: View {
    @Environment(\.modelContext) private var modelContextGrocery
    @Query private var items: [GroceryItem]
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(items) { item in
                    HStack {
                        Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(item.isCompleted ? .green : .gray)
                        Text(item.title)
                            .font(.title2)
                            .fontWeight(.medium)
                            .strikethrough(item.isCompleted, color: .gray)
                            .foregroundStyle(item.isCompleted ? .gray : .primary)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Grocery List")
            .overlay {
                
                if items.isEmpty {
                    ContentUnavailableView(
                        "Sin articulos todavía",
                        systemImage: "cart.fill.badge.minus",
                        description:
                            Text("Pulsa ")
                            .font(.title3) +
                        Text(Image(systemName: "cart.badge.plus"))
                            .font(.title3)
                            .foregroundColor(.accentColor) +
                        Text(" para añadir tu primer artículo")
                            .font(.title3)
                        
                    )
                    .padding()
                }
                
            }
        }
        
    }
}

#Preview {
    GroceryList()
        .modelContainer(for: GroceryItem.self, inMemory: true)
}


#Preview("Sample Data") {
    let sampleData: [GroceryItem] = [
        GroceryItem(title: "Legumbres", isCompleted: true),
        GroceryItem(title: "Papaya", isCompleted: false),
        GroceryItem(title: "Mango", isCompleted: Bool.random()),
        GroceryItem(title: "Arroz", isCompleted: Bool.random())
    ]

    let container = try! ModelContainer(for: GroceryItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    for item in sampleData {
        container.mainContext.insert(item)
    }

    return GroceryList()
        .modelContainer(container)
}
