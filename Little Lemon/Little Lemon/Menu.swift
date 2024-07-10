//
//  Menu.swift
//  Little Lemon
//
//  Created by dana chang on 7/9/24.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var loaded = false
    @State var searchText = ""
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
            TextField("Search menu", text: $searchText)
                                    .textFieldStyle(.roundedBorder)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        NavigationLink(destination: DishDetailView(dish: dish)) {
                            HStack {
                                if let imageUrl = dish.image, let url = URL(string: imageUrl) {
                                    AsyncImage(url: url) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 50, height: 50)
                                }
                                VStack(alignment: .leading) {
                                    Text(dish.title ?? "Untitled")
                                        .fontWeight(.medium)
                                    Text("Price: \(dish.price ?? "N/A")")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
        }.onAppear {
            if !loaded {
                getMenuData()
                loaded = true
            }
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector:
                                    #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        let search = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        return search
    }
    
    func getMenuData() {
        // PersistenceController.shared.clear()
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let menuData = try? decoder.decode(MenuList.self, from: data) {
                    for dish in menuData.menu {
                        let newDish = Dish(context: viewContext)
                        newDish.title = dish.title
                        newDish.price = dish.price
                        newDish.desc = dish.desc
                        newDish.image = dish.image
                        newDish.category = dish.category
                    }
                    try? viewContext.save()
                } else {
                    print(error.debugDescription.description)
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
}

#Preview {
    Menu()
}
