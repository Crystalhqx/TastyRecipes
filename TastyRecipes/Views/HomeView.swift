//
//  HomeView.swift
//  TastyRecipes
//
//  Created by crystal on 8/12/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = MealListViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(viewModel.meals) { meal in
                        NavigationLink(destination: MealDetailView(mealID: meal.id)) {
                            MealCard(meal: meal)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Desserts")
            .onAppear {
                Task {
                    await viewModel.fetchMeals()
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
