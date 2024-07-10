//
//  DishDetailView.swift
//  Little Lemon
//
//  Created by dana chang on 7/9/24.
//

import SwiftUI

struct DishDetailView: View {
    var dish: Dish
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.frame(width: 300, height: 300)
                }
                .aspectRatio(contentMode: .fit)
                
                Text(dish.title ?? "No title")
                    .font(.title)
                    .foregroundColor(.primary)
                
                Text("Price: \(dish.price ?? "N/A")")
                    .font(.headline)
                    .foregroundColor(.secondary)
                // Description
                Text(dish.desc ?? "")
                          .font(.body)
                          .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    DishDetailView()
//}
