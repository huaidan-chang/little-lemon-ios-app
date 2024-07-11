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
    @Binding var loaded: Bool
    @Binding var searchText: String
    @Binding var selectedCategory: Category
    @State private var isLoading = true
    var body: some View {
        VStack {
            Text("Test").font(.KarlaSectionTitle())
            if isLoading {
                    ProgressView()
            } else {
                FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) {
                    (dishes: [Dish]) in
                    ForEach(dishes, id: \.self) { dish in
                        NavigationLink(destination: DishDetailView(dish: dish)) {
                            if selectedCategory == Category.all || dish.category == selectedCategory.rawValue {
                                MenuItemView(dish: dish)
                            }
                        }
                    }
                }
            }
        }.onAppear {
            if !loaded {
                getMenuData()
                whereIsMySQLite()
                loaded = true
            } else {
                isLoading = false
            }
        }
    }
    
    func whereIsMySQLite() {
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding
        
        print(path ?? "Not found")
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
        isLoading = true
        PersistenceController.shared.clear()
        PersistenceController.shared.debugCheckData()
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
        print("isLoading complete!!!!")
        isLoading = false
    }
}

//#Preview {
//    Menu()
//}
