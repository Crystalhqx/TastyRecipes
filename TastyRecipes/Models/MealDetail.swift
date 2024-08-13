//
//  MealDetail.swift
//  TastyRecipes
//
//  Created by crystal on 8/12/24.
//

import Foundation

struct MealDetail: Decodable {
    let id: String
    let name: String
    let thumbnail: String?
    let area: String?
    let instructions: String
    var ingredients: [String]
    var measures: [String]
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
        case area = "strArea"
        case instructions = "strInstructions"
        case youtubeURL = "strYoutube"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
        area = try container.decodeIfPresent(String.self, forKey: .area)
        instructions = try container.decode(String.self, forKey: .instructions)
        youtubeURL = try container.decodeIfPresent(String.self, forKey: .youtubeURL)

        ingredients = []
        measures = []
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for index in 1...20 {
            if let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(index)"),
               let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(index)") {
                let ingredient = try dynamicContainer.decodeIfPresent(String.self, forKey: ingredientKey) ?? ""
                let measure = try dynamicContainer.decodeIfPresent(String.self, forKey: measureKey) ?? ""
                
                if !ingredient.isEmpty {
                    ingredients.append(ingredient)
                }
                if !measure.isEmpty {
                    measures.append(measure)
                }
            }
        }
    }
    
    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        init?(intValue: Int) {
            return nil
        }
    }
}
