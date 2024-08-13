//
//  Meal.swift
//  TastyRecipes
//
//  Created by crystal on 8/12/24.
//

import Foundation

struct Meal: Identifiable, Decodable {
    let id: String
    let name: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }
}
