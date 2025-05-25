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
    
    @State private var item: String = ""
    
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
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            withAnimation {
                                modelContextGrocery.delete(item)
                            }
                        } label: {
                            Label("Eliminar", systemImage: "trash")
                        }
                    }
                    
                    .swipeActions(edge: .leading, allowsFullSwipe: true, content: {
                        Button("Done", systemImage: item.isCompleted == false ? "checkmark.circle" : "x.circle"){
                            item.isCompleted.toggle()
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: .infinity)
                        }
                        .tint(item.isCompleted == false ? Color.green : Color.red)
                    })
                
                }
            }
            .navigationTitle("Grocery List")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        addEssentialFood()
                    }) {
                        Label("Añadir", systemImage: "carrot")
                    }
                }
            }
            .safeAreaInset(edge: .bottom, content: {
                VStack{
                    TextField("Nuevo artículo", text: $item)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    Button {
                        let newItem = GroceryItem(title: item, isCompleted: false)
                        modelContextGrocery.insert(newItem)
                        item = ""
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    } label:{
                        Text("Save")
                            .padding()
                    }
                }
            })
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
    
    func addEssentialFood(){
        modelContextGrocery.insert(GroceryItem(title: "Legumbres", isCompleted: true))
        modelContextGrocery.insert(GroceryItem(title: "Papaya", isCompleted: false))
        modelContextGrocery.insert(GroceryItem(title: "Mango", isCompleted: Bool.random()))
        modelContextGrocery.insert(GroceryItem(title: "Arroz", isCompleted: Bool.random()))
        
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
