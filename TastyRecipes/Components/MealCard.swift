//
//  MealGridItemView.swift
//  TastyRecipes
//
//  Created by crystal on 8/12/24.
//

import SwiftUI

struct MealCard: View {
    let meal: Meal
    
    var body: some View {
        VStack {
            if let url = URL(string: meal.thumbnail) {
                loadImage(url: url)
            }
        }
        .frame(width: 160, height: 220, alignment: .top)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(radius: 10)
        .padding(.horizontal)
    }
    
    private func loadImage(url: URL) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text(meal.name)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .lineLimit(2)
                                .padding(.bottom, 2)
                        }
                        .padding(8)
                        .frame(width: 160, alignment: .center)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]), startPoint: .bottom, endPoint: .top)
                        )
                        .cornerRadius(10)
                    }
                    .scaledToFill()
                    .frame(width: 160, height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct MealCard_Previews: PreviewProvider {
    static var previews: some View {
        MealCard(meal: Meal(id: "1", name: "Anzac BiscuitsAnzac BiscuitsAnzac Biscuits", thumbnail: "https://via.placeholder.com/150"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
