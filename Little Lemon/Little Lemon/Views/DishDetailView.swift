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
                    ProgressView().frame(width: 300, height: 200)
                }
                .aspectRatio(contentMode: .fit)
                
                Text(dish.title ?? "No title")
                    .font(.KarlaSectionTitle())
                    .foregroundColor(.primary)
                
                Text("Price: \(dish.price ?? "N/A")")
                    .font(.KarlaCardTitle())
                    .foregroundColor(.primary1)
                // Description
                Text(dish.desc ?? "")
                    .font(.KarlaHighlightText())
                    .foregroundColor(.secondary4)
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
