//
//  MealDetailView.swift
//  TastyRecipes
//
//  Created by crystal on 8/12/24.
//

import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @StateObject private var viewModel = MealDetailViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    if let mealDetail = viewModel.mealDetail {
                        
                        // Meal Image
                        if let urlString = mealDetail.thumbnail, let url = URL(string: urlString) {
                            loadImage(url: url)
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                                .clipped()
                                .overlay(
                                    Rectangle()
                                        .foregroundColor(Color.black.opacity(0.2))
                                        .edgesIgnoringSafeArea(.all)
                                )
                        }
                        
                        // Meal Name
                        Text(mealDetail.name)
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, 20)
                            .padding(.horizontal)

                        // Meal Area
                        if let area = mealDetail.area {
                            Text(area)
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .padding(8)
                                .background(Color(.systemGray6))
                                .cornerRadius(5)
                                .padding(.horizontal)
                                .padding(.vertical)
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            // Ingredients Section
                            Text("Ingredients")
                                .font(.system(size: 22))
                                .bold()
                                .padding(.horizontal)

                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(0..<mealDetail.ingredients.count, id: \.self) { index in
                                    HStack {
                                        Text(mealDetail.ingredients[index])
                                        Spacer()
                                        Text(mealDetail.measures[index])
                                    }
                                    if index < mealDetail.ingredients.count - 1 {
                                        Divider()
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical)

                            Divider()
                                .padding(.bottom, 12)
                            
                            // Instructions Section
                            Text("Instructions")
                                .font(.system(size: 22))
                                .bold()
                                .padding(.horizontal)
                            Text(mealDetail.instructions)
                                .padding(.horizontal)
                                .padding(.vertical, 12)

                            // Video Link
                            if let youtubeURL = mealDetail.youtubeURL, let url = URL(string: youtubeURL) {
                                Link("Watch Video on YouTube", destination: url)
                                    .font(.headline)
                                    .padding(.vertical, 15)
                                    .frame(maxWidth: .infinity)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(5)
                                    .padding(.horizontal)
                                    .multilineTextAlignment(.center)
                                    .padding(.vertical)
                            }
                                
                        }
                        .padding(.top, 16)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                    } else {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
        .onAppear {
            Task {
                await viewModel.fetchMealDetail(mealID: mealID)
            }
        }
    }
    
    private func loadImage(url: URL) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(mealID: "53049")
    }
}
