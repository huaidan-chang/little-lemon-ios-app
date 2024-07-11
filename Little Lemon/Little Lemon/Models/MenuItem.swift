//
//  MenuItem.swift
//  Little Lemon
//
//  Created by dana chang on 7/9/24.
//

import Foundation

struct MenuItem: Decodable, Identifiable {
    var id = UUID()
    let title : String
    let desc: String
    let price: String
    let image: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case desc = "description"
        case price = "price"
        case image = "image"
        case category = "category"
    }
}
