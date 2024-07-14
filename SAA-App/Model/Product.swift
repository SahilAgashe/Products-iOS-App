//
//  Product.swift
//  SAA-App
//
//  Created by SAHIL AMRUT AGASHE on 13/07/24.
//

import Foundation

struct Product: Decodable {
    let uniqueId: Int
    let title: String
    let price: Float
    let description: String
    let category: String
    let image: String
    let rating: Rating
    
    enum CodingKeys: String , CodingKey {
        case uniqueId = "id"
        case title
        case price
        case description
        case category
        case image
        case rating
    }
}

struct Rating: Decodable {
    let rate: Float
    let count: Int
}
