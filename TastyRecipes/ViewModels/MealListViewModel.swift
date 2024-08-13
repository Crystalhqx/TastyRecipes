//
//  MealListViewModel.swift
//  TastyRecipes
//
//  Created by crystal on 8/12/24.
//

import Foundation

@MainActor
class MealListViewModel: ObservableObject {
    // @Published notifies views when the data changes
    @Published var meals: [Meal] = []
    @Published var isLoading = true
    
    func fetchMeals() async {
        isLoading = true
        do {
            let fetchedMeals = try await MealApi.shared.fetchMeals()
            meals = fetchedMeals
        } catch {
            print("Error fetching meals: \(error)")
        }
        isLoading = false
    }
}
