//
//  MealApi.swift
//  TastyRecipes
//
//  Created by crystal on 8/12/24.
//

import Foundation

class MealApi {
    static let shared = MealApi()
    
    private init() {}
    
    func fetchMeals() async throws -> [Meal] {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
        
        // Filter out null/empty values
        return mealResponse.meals.filter { !$0.name.isEmpty }.sorted { $0.name < $1.name }
    }
    
    func fetchMealDetails(mealID: String) async throws -> MealDetail {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        
        guard var mealDetail = mealDetailResponse.meals.first else {
            throw URLError(.badServerResponse)
        }
        
        // Filter out null/empty values
        mealDetail.ingredients = mealDetail.ingredients.filter { !$0.isEmpty }
        mealDetail.measures = mealDetail.measures.filter { !$0.isEmpty }
        
        return mealDetail
    }
}

struct MealResponse: Decodable {
    let meals: [Meal]
}

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}
