//
//  MealDetailViewModel.swift
//  TastyRecipes
//
//  Created by crystal on 8/12/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    
    func fetchMealDetail(mealID: String) async {
            do {
                let detail = try await MealApi.shared.fetchMealDetails(mealID: mealID)
                mealDetail = detail
            } catch {
                print("Error fetching meal details: \(error)")
            }
        }
}
