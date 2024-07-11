//
//  MenuItemView.swift
//  Little Lemon
//
//  Created by dana chang on 7/11/24.
//

import SwiftUI

struct MenuItemView: View {
    let dish:Dish
    
    var body: some View {
        VStack (alignment: .leading) {
            Divider()
            HStack {
                VStack (alignment: .leading){
                    Text(dish.title ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.KarlaCardTitle())
                        .foregroundColor(.black)
                    Spacer(minLength: 10)
                    Text(dish.desc ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.KarlaParagraphText())
                        .foregroundColor(.primary1)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    Spacer(minLength: 10)
                    Text("$" + (dish.price ?? ""))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.KarlaHighlightText())
                        .foregroundColor(.primary1)
                        .monospaced()
                }.frame(maxWidth: .infinity, alignment: .leading)
                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: 90, maxHeight: 90)
                .clipShape(Rectangle())
            }
            .padding(.vertical)
            .frame(maxHeight: 150)
        }
    }
}

//#Preview {
//    MenuItemView()
//}
